class GenieSearchForm

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :effort_id, :time, :category, :search_field

  validates_presence_of :effort_id, :message => "Invalid dificulty"
  validates_presence_of :time, :message => "Invalid peparation time"
  validates_presence_of :category, :message => "Invalid food category"

 	def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end