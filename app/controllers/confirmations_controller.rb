class ConfirmationsController < Devise::SessionsController
  skip_before_filter :require_login
  skip_before_filter :active_user

	def new
	if session[:omniauth]
			@user = (session[:omniauth])
			binding.pry
			user.email = nil
		    user.name = omni['info']['name']
		    user.location = omni['info'].location
		    user.username = omni['info']['nickname']
		    user.username = user.username.gsub(/[^0-9A-Za-z]/, '') unless user.username.nil?
		end
	end

	def create
		@user = session[:user]
		if User.exists?(params[:user][:id]) && User.find(params[:user][:id]).active == true
			@user = User.find(params[:user][:id])
			sign_in_and_redirect @user
		else
			if params[:user][:orig_username] != nil
				@user.username = params[:user][:orig_username]
			else
				@user.username = params[:user][:username]
			end
			@user.location = params[:user][:location]
			@user.email = params[:user][:email]
			if @user.save
				@user.active = true
				flash[:notice] = "Welcome"
				sign_in_and_redirect @user
			else
				render 'new' 
			end
		end
		super
		session.data.delete [:user, :omniauth] unless @user.new_record
	end

	private

	def build_resource(*args)
		super
		if session[:omniauth]
		@user.apply_omniauth(session[:omniauth])
		@user.valid?
		end
	end

end
