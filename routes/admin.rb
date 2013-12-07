require 'bundler'
Bundler.require

class WebNotes < Sinatra::Base

  %w(/admin/? /admin/users/?).each do |path|
    get path do
      @users = User.all
      session[:return_to] = @request.path
      haml :admin_users
    end
  end

  post '/admin/users/search?' do
    keyword = params[:keyword]
    @users = User.all(:username.like => '%' + keyword + '%')
    haml :admin_users
  end

  get '/admin/delete/user/:id' do
    @user = User.get(params[:id])
    @user.notes(:user => @user).destroy
    @user.destroy

    redirect '/admin/users'
  end

end