require 'spec_helper'

describe "StaticPages" do

	describe "Home Page" do

		it "should have the content 'Sur Le Trottoir'" do
			visit '/static_pages/home'
			page.should have_content('Sur Le Trottoir')
		end
	end

	describe "Help Page" do
		it "should have the content 'Help'" do
			visit '/static_pages/help'
			page { should have_content('Help') }
		end
	end

	describe "Contact Page" do
		it "should have the content 'Contact Us'" do
			visit '/static_pages/contact'
			page { should have_content('Contact Us') }
		end
	end
end
