require 'spec_helper'

describe Blender do

	it "should ensure that a filled blender form is valid" do
		blender_form = FactoryGirl.build(:blender_form)
		blender_form.should be_valid
	end

	it "should parse correctly every ingredient" do
		ingredients = []
		ingredients << "4Kg sugar"
		ingredients << "1 ounces vanilla extract"
		ingredients << "1/4 KG sour cream"
		ingredients << "2 1/5 KG strawberries"
		blender_form = FactoryGirl.build(:blender_form, blending_ingredients: ingredients.join("\n"))
		blender_form.should be_valid

		# Test the blender
		blender = Blender.new(blender_form)
		recipe = blender.blend
		ok_count = 0

		recipe.ingredients.each do |ingredient|
			overall_status = !ingredient.measure.nil? && !ingredient.measure.nil?
			puts "[#{pass_fail(overall_status)}] #{ingredient.pretty_print}: \t\t quantity: [#{pass_fail(!ingredient.quantity.nil?)}] / measure: [#{pass_fail(!ingredient.measure.nil?)}] / name: #{ingredient.food_item.name}"
			ok_count += 1 if overall_status
		end

		assert (ok_count == recipe.ingredients.size)		
	end

	private
	def pass_fail boolean
		if boolean
			return "OK"
		else
			return "NOT OK" 
		end
	end


end