class Listing < ActiveRecord::Base
  belongs_to :users

def self.my_listings(user_id)
  @listings = Listing.all.find{|user| user.user_id == user_id}
end

end
