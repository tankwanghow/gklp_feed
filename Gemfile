source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '4.1.0.rc1'
gem 'rails', '>= 4.1.0.rc2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-unicorn-nginx'  
  gem 'capistrano-rbenv-install'
  gem 'capistrano-safe-deploy-to'
  gem 'capistrano-postgresql'
end

gem 'pg'

gem 'monetize'
gem 'money', '~> 6.1.0.beta1'
gem 'sentient_user'
gem 'nested_form'
gem 'prawn'
gem 'simple_form', '~> 3.0.1'
gem 'haml'
gem 'haml-rails'
gem 'kaminari'
gem 'bootstrap-kaminari-views'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby'

# Use unicorn as the web server
gem 'unicorn'

gem 'therubyracer', :platforms => :ruby
gem 'bootstrap-sass'
# gem 'jquery-ui-rails'

group :test do
  gem 'minitest'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :test, :development do
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
end
