class AdminController < ApplicationController
  use Rack::Flash

get "/admin/admin-main" do
  if logged_in?
    @user = current_user
    if @user.id == "1"
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
    if @user.id == "1"
      erb :'/admin/all-users'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect to '/'
    end
  end
end

get "/admin/all-listings" do
  if logged_in?
    @user = current_user
    if @user.username == "rabbiben"
      erb :'/admin/all-listings'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect to '/'
    end
  end
end





end
