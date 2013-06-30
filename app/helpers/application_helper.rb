module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = t('site_name') 
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}" 
		end
	end

	def sign_in(user)
	    cookies.permanent[:remember_token] = user.remember_token
	    self.current_user = user
	end

	def signed_in?
	    !current_user.nil?
	end
end
