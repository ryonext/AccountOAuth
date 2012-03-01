class User < ActiveRecord::Base
  
  def self.create_with_omniauth(auth)
    create! do |user|
      #これは必須
      #TwitterID
      user.twitter_id = auth["uid"]
      #これは好みで。Twitterから引き継いで使いたければ使う。
      #Twitterのスクリーンネーム
      user.nickname = auth["info"]["name"]
      #Twitterのニックネーム
      user.screen_name = auth["info"]["nickname"]
      #Twitterのlocation
      user.location = auth["info"]["location"]
      #Twitterのdescription
      user.profile = auth["info"]["description"]
      #この辺はサービス固有のものなのでなにもしない
      #user.last_login
    end
  end
end
