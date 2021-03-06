require 'bundler'
Bundler.require

class WebNotes < Sinatra::Base
  register Sinatra::Contrib

  def warden
    env['warden']
  end

  def check_authentication
    redirect '/login' unless warden.authenticated?
  end

  get '/login/?' do
    haml :login
  end

  post '/login/?' do
    warden.authenticate!
    if session[:return_to].nil?
      redirect redirect_default
    else
      redirect session[:return_to]
    end
  end

  get '/logout' do
    warden.logout
    redirect '/'
  end

  post '/register/?' do
    user = params['user']
    existing_user = User.first(User.username => params['user']['username'])

    if existing_user.nil?
      User.create(user)
      flash[:msg] = 'Registration successfully completed!'
    else
      flash[:error] = 'The specified name already exists. Please select a different name.'
    end

    haml :login
  end

  post '/protected/save/user/?' do
    user_info = params['user']
    user = User.get(user_info[:id])
    updated = user.update(user_info)

    if updated
      flash[:msg] = 'Saved!'
    else
      flash[:error] = 'Error: user info not saved!'
    end

    redirect '/protected/settings'
  end


  post '/auth/unauthenticated/?' do
    session[:return_to] = env['warden.options'][:attempted_path]
    flash[:error] = warden.message || 'The user does not exist or password specified incorrectly'
    redirect '/login/', 303
  end

  %w(/protected/* /admin/?:remainder?).each do |path|
    before path do
      warden.authenticate!
      @current_user = warden.user
    end
  end


  #Warden configuration
  use Rack::Session::Cookie, secret: "nothingissecretontheinternet"
  use Rack::Flash, accessorize: [:error, :success]

  use Warden::Manager do |config|
    config.serialize_into_session { |user| user.id }
    config.serialize_from_session { |id| User.get(id) }

    config.scope_defaults :default,
                          strategies: [:password],
                          action: 'auth/unauthenticated'
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env, opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['user'] && params['user']['username'] && params['user']['password']
    end

    def authenticate!
      user = User.first(username: params['user']['username'])

      if user.nil?
        fail!('The username does not exist.')
      elsif user.authenticate(params['user']['password'])
        session[:user] = user
        success!(user)
      else
        fail!('Could not log in')
      end
    end
  end

end