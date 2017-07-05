class AdminController < ApplicationController
  use Rack::Flash

get "/admin/admin-main" do
  @user = current_user
  if logged_in?
    if @user.id == "1"
      erb :'/admin/admin-main'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect '/index'
    end
  end
end

get "/admin/all-users" do
  @user = current_user
  if logged_in?
    if @user.id == "1"
      erb :'/admin/all-users'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect '/index'
    end
  end
end







end
