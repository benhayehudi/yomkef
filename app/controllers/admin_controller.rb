class AdminController < ApplicationController
  use Rack::Flash

get "/admin/admin-main" do
  if logged_in?
    @user = current_user
    if @user.id == 1
      erb :'/admin/admin-main'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect to '/'
    end
  end
end

get "/admin/all-users" do
  if logged_in?
    @user = current_user
    if @user.id == 1
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
    if @user.id == 1
      erb :'/admin/all-listings'
    else
      flash[:admin_access_error] = "You must be an administrator to access this page."
      redirect to '/'
    end
  end
end

get "/admin/edit-listing/:id" do
if logged_in?
  @user = current_user
  if @user.id == 1
    erb :'/admin/edit-listing'
  else
    flash[:admin_access_error] = "You must be an administrator to access this page."
    redirect to '/'
    end
  end
end

get "/admin/delete-listing/:id" do
if logged_in?
  @user = current_user
  if @user.id == 1
    listing_entry = Listing.find_by_id(params[:id])
    listing_entry.delete
    redirect to '/admin/all-listings'
  else
    flash[:admin_access_error] = "You must be an administrator to access this page."
    redirect to '/'
    end
  end
end

get "/admin/edit-user/:id" do
if logged_in?
  @user = current_user
  if @user.id == 1
    erb :'/admin/edit-user'
  else
    flash[:admin_access_error] = "You must be an administrator to access this page."
    redirect to '/'
    end
  end
end

get "/admin/delete-user/:id" do
if logged_in?
  @user = current_user
  if @user.id == 1
    user_entry = User.find_by_id(params[:id])
    user_entry.delete
    redirect to '/admin/all-users'
  else
    flash[:admin_access_error] = "You must be an administrator to access this page."
    redirect to '/'
    end
  end
end


end
