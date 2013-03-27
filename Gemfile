source 'https://rubygems.org'

ruby "1.9.3"
gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongodb'
gem "mongoid", "~> 3.0.0"
gem "bson","~> 1.4.0"
gem 'bson_ext',"~> 1.4.0"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem "therubyracer"
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem "twitter-bootstrap-rails"
gem 'jquery-rails'
gem 'angularjs-rails'

gem 'coveralls', require: false

group :test,:development do
  gem 'rb-fsevent', '~> 0.9.1'
  gem "rspec-rails"
end
group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "database_cleaner"
end
