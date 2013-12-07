def current_user
  session[:user]
end

def redirect_default
  case current_user.role
    when :user
      '/protected/notes'
    when :admin
      '/admin'
    else
      '/'
  end
end

def get_user_navigation_part
  current_user.nil? ? :nav_login_form_part : :nav_user_options_part
end

def get_sidebar_part
  current_user.role == :admin ? :nav_sidebar_admin_part : :nav_sidebar_part
end