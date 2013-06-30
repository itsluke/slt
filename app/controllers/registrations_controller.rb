class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_login
  skip_before_filter :active_user

  def create
  	super
  	session[:omniauth] = nil unless @user.new_record?
  end

  def build_resource(*args)
    super
    if session[:omniauth]['provider'] == 'twitter'
      @user.apply_omniauth(session[:omniauth])
      # binding.pry
      @user.name = session[:omniauth]['info']['name']
      @user.location = session[:omniauth]['info'].location
      @user.username = session[:omniauth]['info']['nickname']
      @user.username = @user.username.gsub(/[^0-9A-Za-z]/, '') unless @user.username.nil?
      @user.valid?
    elsif session[:omniauth]['provider'] == 'facebook'
      @user.apply_omniauth(session[:omniauth])
      @user.email = session[:omniauth]['extra']['raw_info'].email
      @user.name = session[:omniauth]['extra']['raw_info'].name
      @user.location = session[:omniauth]['extra']['raw_info']['location'].name
      @user.valid?
    end
  end

end