class LineitemdateController < ApplicationController
  before_action :set_restaurant

  def new
    @line_item_date = @restaurant.line_item_dates.build
  end

  def create
    @line_item_date = @restaurant.line_item_dates.build(line_item_date_params)

    if @line_item_date.save
      redirect_to restaurant_path(@restaurant), notice: "Date was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def line_item_date_params
    params.require(:line_item_date).permit(:date)
  end

  def set_restaurant
    @restaurant = current_company.restaurants.find(params[:restaurant_id])
  end
end
