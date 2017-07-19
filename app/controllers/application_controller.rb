require './config/environment'
require "./app/models/user"
require "./app/models/listing"

require 'rack-flash'
# set :database, "sqlite3:./db/development.sqlite3"


class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "yomkef_bitachon"
  end

  get "/" do
    erb :index
  end

  get "/about" do
    erb :about
  end

  get "/contact" do
    erb :contact
  end

  get "/registrations/signup" do
    erb :'/registrations/signup'
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:email] !~ (/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    redirect '/registrations/signup'
    else
      @user = User.create(name: params["name"], username: params["username"], email: params["email"], password: params["password"])
      session[:user_id] = @user.id
      redirect '/users/user_update'
    end
  end

  get "/users/user_update" do
    if logged_in?
      @user = current_user
      erb :"/users/user_update"
    else
      flash[:user_update_error] = "You must be logged in to update your profile. Please login first."
      redirect '/login'
    end
  end

  post "/user_update" do
    if logged_in?
      @user = current_user
      @user.update_attributes(:name => params["name"], :username => params["username"], :email => params["email"], :facebook_url => params["facebook_url"], :twitter_url => params["twitter_url"], :instagram_url => params["instagram_url"], :about_me => params["about_me"])
      @user.save
      redirect to "/users/user_main"
    else
      flash[:edit_profile_error] = "You must be logged in to edit your profile. Please login first."
      redirect to "/login"
    end
  end

  post "/update-pw" do
    if logged_in?
      @user = current_user
      @user && @user.authenticate(params[:old_password])
      @user.update_attribute(:password, params[:new_password])
        unless @user.password != params[:old_password] && params[:new_password].nil? || params[:new_password].empty?
          @user.save
          redirect to "/users/user_main"
        else
          flash[:pw_reset_error] = "Incorrect attempt. Please try again."
          redirect to "/users/user_update"
        end
      end
    end

  get "/users/user_main" do
    @user = current_user
    @lists = Listing.find_by(:submitted_by => params[:submitted_by])
    erb :'/users/user_main'
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
     flash[:notice] = "Welcome, #{@user.username}!"
     redirect '/users/user_main'
    else
      flash[:error] = "Incorrect login. Please try to login again."
      redirect '/sessions/login'
    end
  end


  get "/success" do
    if logged_in?
      erb :success
    else
      redirect "/login"
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def facebook_url?
      if @user.facebook_url == nil
        "Facebook Link"
      else
        @user.facebook_url
      end
    end

    def twitter_url?
      if @user.twitter_url == nil
        "Twitter Link"
      else
        @user.twitter_url
      end
    end

    def instagram_url?
      if @user.instagram_url == nil
        "Instagram Link"
      else
        @user.instagram_url
      end
    end

    def about_me?
      if @user.about_me == nil
        "About Me"
      else
        @user.about_me
      end
    end
  end
end 
