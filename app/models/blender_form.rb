class BlenderForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

	attr_accessor :title
  attr_accessor :effort, :time, :category, :many_ppl
  attr_accessor :blending_ingredients, :blending_text

  validates_presence_of :effort, 	    :message => "Please choose a difficulty"
  validates_presence_of :time, 				:message => "Choose the cooking time"
  validates_presence_of :category, 		:message => "Choose a food category"
  validates_presence_of :many_ppl, 		:message => "Choose the number of eaters"
  validates_presence_of :title, 			:message => "Choose a title"
  
  validates_numericality_of :many_ppl, :time
  
  validates_presence_of :blending_ingredients, 	:message => "Cant blend without ingredients"
  validates_presence_of :blending_text, 				:message => "You need to provide a recipe description"


 	def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end

