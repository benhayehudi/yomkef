class ListsController < ApplicationController

get "/admin/admin-main.erb" do
  erb :'/admin/admin-main'
end

get "/admin/all-users" do
  erb :'/users/all-users'
end







end
