class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

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
        format.turbo_stream
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
  end

  def edit
    # @restaurant = Restaurant.find(params[:id])
  end

  def update
    # @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      flash[:notice] = "You've successfully updated your restaurant!"
      # redirect_to restaurant_path(@restaurant.id)
      redirect_to restaurants_path
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
      format.turbo_stream
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:address, :name)
  end

  def set_restaurant
    # We must use current_company.quotes here instead of Quote
    # for security reasons
    @restaurant = current_company.restaurants.find(params[:id])
  end

end
