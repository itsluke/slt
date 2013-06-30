source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.3'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'nifty-generators'
gem "rack", "~> 1.4.1"

gem "pg", "~> 0.15.1"
gem "thin", "~> 1.5.1"

# redis
gem 'redis'
gem "redis-rails", "~> 3.2.3"

# authentication
gem "devise", "~> 2.2.4"
gem "omniauth", "~> 1.1.4"
gem "omniauth-facebook", "~> 1.4.1"
gem "omniauth-twitter", "~> 0.0.7"
gem 'twitter'
gem 'fb_graph'

# geo gems
gem "geocoder", "~> 1.1.8"

group :development do
	gem 'annotate', ' ~> 2.4.1.beta'
	gem 'rspec-rails', '2.10.0'
	gem "pry", "~> 0.9.12.2"
end

# in production environments by default.

group :assets do
  gem 'sass-rails',   '3.2.4'
  gem "compass-rails", "~> 1.0.3"
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '~> 2.0.0'

group :test, :development do 

	gem 'rspec-rails', '2.10.0' 
	gem 'guard-rspec', '0.5.5' 
	gem 'guard-spork', '0.3.2' 
	gem 'spork', '0.9.0'
	gem 'rb-fsevent', '0.9.1'
end

group :test do
	gem 'capybara', '1.1.2'
	gem 'factory_girl_rails', '~> 4.2.1'
	gem 'cucumber-rails', '1.2.1', require: false 
	gem 'database_cleaner', '0.7.1'
	gem 'rb-fsevent', '0.9.1', :require => false 
	gem 'growl', '1.0.3'
end