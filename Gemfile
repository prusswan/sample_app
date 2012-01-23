source 'http://rubygems.org'

gem 'rails', '3.2.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'gravatar_image_tag'
gem 'will_paginate', '>= 3.0.pre4'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate', '~> 2.4.1.beta1'
  gem 'faker'
  gem 'guard-rspec'
end

group :test do
  gem 'spork-rails'
  gem 'webrat' # used for have_selector
  gem 'factory_girl_rails'
  gem 'capybara'
  # gem 'turn'
  # gem 'minitest'

  # System-dependent gems for guard
  # On windows
  gem 'win32console' # for guard to use color
  gem 'rb-fchange'
  # gem 'rb-notifu' # system tray notification
  gem 'ruby_gntp'   # Growl notification

  gem 'guard-spork' # for guard to evoke spork
end

group :production do
  # http://stackoverflow.com/questions/7296683/rails-3-1-pushing-to-heroku-errors-installing-postgres-adapter
  # gems specifically for Heroku go here
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
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

