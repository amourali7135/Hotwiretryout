class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]

  def index
    @restaurants = current_company.restaurants.ordered
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    # @restaurant = Restaurant.new(restaurant_params)
    @restaurant = current_company.restaurants.build(restaurant_params)
    if @restaurant.save
      respond_to do |format|
        format.html { redirect_to restaurants_path, notice: "Restaurant was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Restaurant was successfully created." }
      end
    else
      flash[:error] = 'There was an error, please try again!'
      render 'new', status: :unprocessable_entity
    end
    # raise
  end

  def show
    # @restaurant = Restaurant.find(params[:id])
    @review = Review.new # Add this line
    @line_item_dates = @restaurant.line_item_dates.ordered
  end

  def edit
    # @restaurant = Restaurant.find(params[:id])
  end

  def update
    # @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      respond_to do |format|
        format.html { redirect_to restaurants_path, notice: "restaurant was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "restaurant was successfully updated." }
      end
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    # @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    # flash[:notice] = "You've successfully deleted this restaurant!"
    # redirect_to restaurants_path
    respond_to do |format|
      format.html { redirect_to restaurants_path, notice: "Restaurant was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Restaurant was successfully destroyed." }
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:address, :name)
  end

  def set_restaurant
    # We must use current_company.restaurants here instead of restaurant
    # for security reasons
    @restaurant = current_company.restaurants.find(params[:id])
  end
end
