class ServiceController < ApplicationController
  def index
    #画面に出すためのユーザー情報を取得
    @user = User.find(session[:user_id])
    #最終ログイン日更新（画面にはセッションの値を使う。）
    @user.update_attribute(:last_login, Time.now)
    #画面に出す最終ログイン日（セッションの値）
    @last_login = session[:last_login]
  end

end
