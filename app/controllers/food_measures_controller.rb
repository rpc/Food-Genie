class FoodMeasuresController < ApplicationController
  # GET /food_measures
  # GET /food_measures.json
  def index
    @food_measures = FoodMeasure.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @food_measures }
    end
  end

  # GET /food_measures/1
  # GET /food_measures/1.json
  def show
    @food_measure = FoodMeasure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food_measure }
    end
  end

  # GET /food_measures/new
  # GET /food_measures/new.json
  def new
    @food_measure = FoodMeasure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food_measure }
    end
  end

  # GET /food_measures/1/edit
  def edit
    @food_measure = FoodMeasure.find(params[:id])
  end

  # POST /food_measures
  # POST /food_measures.json
  def create
    @food_measure = FoodMeasure.new(params[:food_measure])

    respond_to do |format|
      if @food_measure.save
        format.html { redirect_to @food_measure, notice: 'Food measure was successfully created.' }
        format.json { render json: @food_measure, status: :created, location: @food_measure }
      else
        format.html { render action: "new" }
        format.json { render json: @food_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /food_measures/1
  # PUT /food_measures/1.json
  def update
    @food_measure = FoodMeasure.find(params[:id])

    respond_to do |format|
      if @food_measure.update_attributes(params[:food_measure])
        format.html { redirect_to @food_measure, notice: 'Food measure was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @food_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_measures/1
  # DELETE /food_measures/1.json
  def destroy
    @food_measure = FoodMeasure.find(params[:id])
    @food_measure.destroy

    respond_to do |format|
      format.html { redirect_to food_measures_url }
      format.json { head :ok }
    end
  end
end
