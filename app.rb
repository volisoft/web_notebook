require 'yaml'
require 'sinatra'
require 'haml'

class WebNotes < Sinatra::Base
  enable :logging
  set :environments, %w{development test production staging}
end

require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/helper'
