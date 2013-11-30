def current_user
  session[:user]
end

def get_user_navigation_part
  current_user.nil? ? :nav_login_form_part : :nav_user_options_part
end