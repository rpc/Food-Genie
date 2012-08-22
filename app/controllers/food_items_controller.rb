class FoodItemsController < ApplicationController

  def index
    @food_items = FoodItem.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @food_items.map(&:name)
  end

  def show
    @food_item = FoodItem.find(params[:id])
  end

  def new
    @food_item = FoodItem.new
  end

  def edit
    @food_item = FoodItem.find(params[:id])
  end

  def create
    @food_item = FoodItem.new(params[:food_item])

    if @food_item.save
      redirect_to @food_item, notice: 'Food item was successfully created.'
    else
      render :new
    end
  end

  def update
    @food_item = FoodItem.find(params[:id])

    if @food_item.update_attributes(params[:food_item])
      redirect_to @food_item, notice: 'Food item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food_item = FoodItem.find(params[:id])
    @food_item.destroy

    redirect_to food_items_url, notice: "Successfully destroyed food item."
  end
end
