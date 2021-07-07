source 'https://rubygems.org'
gem 'data_mapper', '>= 1.2.0'

group :development, :test do
  gem 'dm-sqlite-adapter', '>= 1.2.0'
end

group :production, :staging do
  gem 'dm-postgres-adapter', '>= 1.2.0'
end

gem 'sinatra', require: 'sinatra/base', require: 'sinatra/namespace', require: 'sinatra/content_for'
gem 'sinatra-contrib'
gem 'haml'
gem 'rack-flash3', require: 'rack/flash'
gem 'rack-handlers', require: 'rack/handler'
gem 'warden'
gem 'thin'