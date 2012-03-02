class Ingredient < ActiveRecord::Base
  belongs_to :food_item
  belongs_to :recipe
  
  before_save :do_not_repeat_food_item
  after_destroy :destroy_associated_food_items  
  
  def do_not_repeat_food_item
    # If the inserted FoodItem already exists, gets that one.
    unless self.food_item.nil? || self.food_item.valid?
      f_item = FoodItem.find_by_name self.food_item.name  
      self.food_item_id = f_item.id unless f_item.blank?
    end        
  end
  
  def destroy_associated_food_items
    food_items = Ingredient.find(:all, :conditions => ['food_item_id = ? and id != ?',self.food_item_id,self.id])
    self.food_item.destroy if food_items.blank?
  end  
  
  def food_item_name
    self.food_item.name if food_item
  end
  
  def food_item_name
    food_item.try(:name)
  end
  
end
