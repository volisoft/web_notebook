require 'data_mapper'
require 'bcrypt'

configure :staging do
  DB_URL = ENV['HEROKU_POSTGRESQL_MAROON_URL']
end

configure :development do
  DB_URL = "sqlite3://#{Dir.pwd}/db/dev.db"
end

configure :production do
  DB_URL = ENV['DATABASE_URL']
end

require_relative 'model'

DataMapper::setup(:default, DB_URL || 'sqlite3::memory:')
DataMapper.finalize
DataMapper.auto_upgrade!