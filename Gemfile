source 'https://rubygems.org'
gem 'data_mapper'

group :development, :test do
  gem 'dm-sqlite-adapter'
end

group :production, :staging do
  gem 'dm-postgres-adapter'
end

gem 'sinatra', '>= 2.2.0', require: 'sinatra/base', require: 'sinatra/namespace', require: 'sinatra/content_for'
gem 'sinatra-contrib', '>= 2.2.0'
gem 'haml'
gem 'rack-flash3', require: 'rack/flash'
gem 'rack-handlers', require: 'rack/handler'
gem 'warden'
gem 'thin'