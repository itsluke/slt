class AuthenticationsController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :active_user
  
  def home

  end

  def index
    @authentications = Authentication.all
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end

  def failure
    flash[:notice] = t('failure')
    redirect_to new_user_registration_path
  end

  def twitter
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])
    if authentication
      flash[:notice] = t('welcome_back')
      sign_in_and_redirect(User.find(authentication.user_id))
    elsif current_user
      token = omni['credentials'].token
      token_secret = omni['credentials'].secret
      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      flash[:notice] = t('auth.added')
      sign_in_and_redirect(current_user)
    else
      user = User.new
      user.email = nil
      user.name = omni['info']['name']
      user.location = omni['info'].location
      user.username = omni['info']['nickname']
      user.username = user.username.gsub(/[^0-9A-Za-z]/, '') unless user.username.nil?
      user.apply_omniauth(omni)
      if user.save
        flash[:notice] = "Logged In"
        sign_in_and_redirect(User.find(user.id))
      else
        session[:omniauth] = omni.except('extra')
        redirect_to new_user_registration_path
      end
    end
  end

  def facebook
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])
    if authentication
      flash[:notice] = t('welcome_back')
      sign_in_and_redirect(User.find(authentication.user_id))
    elsif current_user
      token = omni['credentials'].token
      token_secret = omni['credentials'].secret
      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      flash[:notice] = t('auth.added')
      sign_in_and_redirect(current_user)
    else
      user = User.new
      user.email = omni['extra']['raw_info'].email
      user.name = omni['extra']['raw_info'].name
      user.location = omni['extra']['raw_info']['location'].name
      # user.username = omni['extra']['raw_info'].username
      # user.username = user.username.gsub(/[^0-9A-Za-z]/, '') unless user.username.nil?
      user.apply_omniauth(omni)
      if user.save
        flash[:notice] = "Logged In"
        sign_in_and_redirect(User.find(user.id))
      else
        session[:omniauth] = omni.except('extra')
        redirect_to new_user_registration_path
      end
    end
  end

end