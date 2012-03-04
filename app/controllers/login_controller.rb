#encoding: utf-8
class LoginController < ApplicationController

  #Twitterでログインボタン押下後の処理
  def auth
    #Twitterの情報を取得
    auth = request.env["omniauth.auth"]


    #DBにデータはある？
    user = User.find_by_twitter_id(auth["uid"])
    if user == nil
      #無いなら登録
      user = User.create_with_omniauth(auth)
    end
    #ユーザーIDをセッションに入れる
    session[:user_id] = user.id
    #最終ログイン日もセッションに入れる
    session[:last_login] = user.last_login
    #ログインしたあとのページヘ
    redirect_to :controller=>'service', :action=>'index'
  end

  def login
    if request.post?
      user = User.authenticate(params[:login_id], params[:password])
      if user
        #ユーザーIDをセッションに入れる
        session[:user_id] = user.id
        #最終ログイン日もセッションに入れる
        session[:last_login] = user.last_login
        #ログインしたあとのページヘ
        redirect_to :controller=>'service', :action=>'index'
      else
        flash.now[:notice] = "ユーザーIDとパスワードの組み合わせが間違っています"
      end
    end
  end

end
