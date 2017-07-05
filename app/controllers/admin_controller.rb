class AdminController < ApplicationController
  use Rack::Flash

get "/admin/admin-main" do
  if logged_in?
    @user = current_user
    if @user.username == "rabbiben"
      erb :'/admin/admin-main'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect to '/index'
    end
  end
end

get "/admin/all-users" do
  if logged_in?
    @user = current_user
    if @user.username == "rabbiben"
      erb :'/admin/all-users'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect to '/index'
    end
  end
end







end
