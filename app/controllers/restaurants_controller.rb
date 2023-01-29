class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = 'Your restaurant was successfully created!'
      redirect_to restaurants_path, method: :get
    else
      flash[:error] = 'There was an error, please try again!'
      render 'new', status: :unprocessable_entity
    end
    # raise
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new  # Add this line
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      flash[:notice] = "You've successfully updated your restaurant!"
      redirect_to restaurant_path(@restaurant.id)
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = "You've successfully deleted this restaurant!"
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:address, :name)
  end
end
