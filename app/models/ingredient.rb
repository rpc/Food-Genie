class Ingredient < ActiveRecord::Base

  attr_accessible :food_item, :food_item_id, :quantity, :measure, :recipe_id, :food_item_attributes

  belongs_to :food_item
  belongs_to :recipe
  
  before_validation :find_existing_food_item
  after_destroy :destroy_associated_food_items

  accepts_nested_attributes_for :food_item, allow_destroy: true, :reject_if => lambda { |a| a[:name].blank? }

  def find_existing_food_item
    # If the inserted FoodItem already exists, gets that one.
    # The creation of the fooditem is up to the FoodItem Model itself
    unless self.food_item.nil? || self.food_item.valid?
      f_item = FoodItem.find_by_name self.food_item.name 
      self.food_item = f_item unless f_item.blank?
    end     
  end
  
  def destroy_associated_food_items
    food_items = Ingredient.find(:all, :conditions => ['food_item_id = ? and id != ?',self.food_item_id,self.id])
    self.food_item.destroy if food_items.blank?
  end 
  
  def food_item_name
    food_item.try(:name)
  end

  def pretty_print
    return "#{quantity} #{measure} #{food_item.name}"
  end
  
end
