#
# upgraded from rails 3.2.3 to rails 4.0.0, on Nov 10th 2013
# 

source 'https://rubygems.org'

gem 'rails', '4.0.0'

# Use zurb foundation for styling and layout
gem 'foundation-rails', '5.4.5' # keep version 5.4.5
gem 'foundation-icons-sass-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Gems used only for assets and not required
# in production environments by default.
gem 'sprockets-rails'
# these gems need to be version 4.0.0
gem 'coffee-rails', '~> 4.0.0'

# uglifier needs to be version 1.3.0 or greater to support rails 4.0
gem 'uglifier', '>= 1.3.0'

# newly added for Rails 4
gem 'turbolinks'

# after upgrading, rake db:create returns the error message "javascript missing"
# so, I added this back again
gem 'therubyracer', platforms: :ruby

gem 'pg'
gem 'pg_search'

# will_paginate supports rails 3.x and rails 4.0
gem 'will_paginate', '~> 3.0'

gem 'geocoder', '~> 1.1.9'

gem 'devise'
# acts-as-taggable-on supports rails 3.x and rails 4.0 if version 2.4.1 or greater is used
gem 'acts-as-taggable-on', '~> 2.4.1'

gem 'redcarpet'
gem 'albino'
gem 'nokogiri'
gem 'coderay'
gem 'jquery-rails'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
