class Category < ActiveRecord::Base
  has_one :recipe
end
