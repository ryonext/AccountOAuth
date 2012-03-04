#encoding: utf-8
require 'digest/sha1'

class User < ActiveRecord::Base
   
  validates_presence_of :login_id
#  validates_uniqueness_of :login_id
  attr_accessor       :password_confirmation
  validates_confirmation_of :password
#  validate :password_non_blank

  def self.create_with_omniauth(auth)
    create! do |user|
      #これは必須
      #TwitterIDをlogin_idにする
      user.login_id = auth["uid"]
      #providerをTwitterにする
      user.provider = "twitter"

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

  def self.authenticate(login_id, password)
    user = self.find_by_login_id_and_provider(login_id, "original")
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end


  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  private

  def password_non_blank
    errors.add(:password, "パスワードを入れてください") if hashed_password.blank?
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
