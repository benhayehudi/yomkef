class AdminController < ApplicationController
  use Rack::Flash

get "/admin/admin-main" do
  logged_in?
  @user = current_user
  if @user.id == "1"
  erb :'/admin/admin-main'
  else
    flash[:admin_access_error] = "You must be an administrator to access this page."
    redirect '/index'
end

get "/admin/all-users" do
  logged_in?
  @user = current_user
  if @user.id == "1"
  erb :'/admin/all-users'
else
  flash[:admin_access_error] = "You must be an administrator to access this page."
  redirect '/index'
end







end
