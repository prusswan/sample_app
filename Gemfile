source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

group :development do
  gem 'rspec-rails'
  gem 'annotate', '2.4.1.beta1'
end

group :test do
  gem 'rspec-rails'
  gem 'spork', '> 0.9.0.rc'
  gem 'webrat' # used for have_selector
  gem 'factory_girl_rails'
end

group :production do
  # http://stackoverflow.com/questions/7296683/rails-3-1-pushing-to-heroku-errors-installing-postgres-adapter
  # gems specifically for Heroku go here
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

