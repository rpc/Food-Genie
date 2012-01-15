class Ingredient < ActiveRecord::Base
  belongs_to :food_item
  belongs_to :recipe
  
  validate :food_item_is_valid
  
  def food_item_is_valid
    errors.add(:food_item, "FoodItem is invalid") unless self.food_item.valid?
  end
  
  before_save :do_not_repeat_food_item
  
  def do_not_repeat_food_item
    # If the inserted FoodItem already exists, gets that one.
    unless self.food_item.nil? || self.food_item.valid?
      f_item = FoodItem.find_by_name self.food_item.name  
      self.food_item_id = f_item.id unless f_item.blank?
    end    
  end
end
