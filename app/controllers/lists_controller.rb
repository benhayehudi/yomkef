class ListsController < ApplicationController

  get "/sessions/my-listings" do
    if logged_in?
      @user = current_user
      erb :'/sessions/my-listings'
    else
      flash[:my_listing_error] = "You must be logged in to view your listings. Please login first."
      redirect to '/login'
    end
  end

  get "/listings/all_listings" do
    erb :'/listings/all_listings'
  end

  get "/sessions/add-listing" do
    if logged_in?
      @user = current_user
      erb :'/sessions/add-listing'
    else
      flash[:add_listing_error] = "You must be logged in to add a listing. Please login first."
      redirect to "/login"
    end
  end

  post "/add-listing" do
    @user = current_user
    if logged_in?
      unless params[:name] == "" || params[:description] == "" || params[:location] == "default" || params[:item_category] == "selection"
        @listing = Listing.create(name: params["name"], location: params["location"], url: params["url"], img_url: params["img_url"], item_category: params["item_category"], description: params["description"], user_id: params["user_id"])
      redirect '/listings/all_listings'
      else
        flash[:add_listing_error] = "You must be logged in to add a listing and submit all required information. Please try again."
        redirect to "/login"
      end
    end
  end

  get '/search-listings' do
    erb :'/listings/search-listings'
  end

  get '/sessions/add-listing-item/:id' do
    if logged_in?
      user_id = session[:user_id]
      listing = Listing.find_by_id(params[:id])
      @new_listing = Listing.create(name: listing.name, location: listing.location, url: listing.url, img_url: listing.img_url, item_category: listing.item_category, description: listing.description, user_id: user_id)
      @new_listing.save
    redirect '/users/user_main'
    else
      flash[:add_listing_error] = "You must be logged in to add a listing. Please login first."
      redirect to "/login"
    end
  end

  get '/sessions/edit-listing/:id' do
    @listing = Listing.find_by_id(params[:id])
    if logged_in?
      @listing = Listing.find_by_id(params[:id])
      erb :'/sessions/edit-listing'
    else
      flash[:edit_listing_error] = "You must be logged in to edit a listing. Please login first."
      redirect to "/login"
    end
  end

  post '/listing-update/:id' do
    @user = current_user
    @listing = Listing.find_by_id(params[:id])
    if logged_in?
      @listing.update_attributes(name: params["name"], location: params["location"], url: params["url"], img_url: params["img_url"], item_category: params["item_category"], description: params["description"])
      @listing.save
      redirect '/sessions/my-listings'
    else
      flash[:edit_listing_error] = "You must be logged in to edit a listing. Please login first."
      redirect to "/login"
    end
  end

  get '/listings/show/:id' do
    @listing = Listing.find_by_id(params[:id])
    erb :'/listings/show'
  end
end
