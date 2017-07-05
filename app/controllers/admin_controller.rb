class AdminController < ApplicationController

get "/admin/admin-main.erb" do
  erb :'/admin/admin-main'
end

get "/admin/all-users" do
  erb :'/admin/all-users'
end







end
