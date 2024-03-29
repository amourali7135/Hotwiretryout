class LineItemDatesController < ApplicationController
  before_action :set_restaurant
  before_action :set_line_item_date, only: %i[edit update destroy]

  def new
    @line_item_date = @restaurant.line_item_dates.build
  end

  def edit
  end

  def create
    @line_item_date = @restaurant.line_item_dates.build(line_item_date_params)

    if @line_item_date.save
      respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant), notice: "Date was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Date was successfully created." }
      end
    else
      flash[:error] = 'There was an error, please try again!'
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @line_item_date.update(line_item_date_params)
      respond_to do |format|
        format.html { redirect_to restaurant_path(@restaurant), notice: "Date was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Date was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @line_item_date.destroy

  #   redirect_to restaurant_path(@restaurant), notice: "Date was successfully destroyed."
  # end

  def destroy
    @line_item_date.destroy

    # Why does turbo not work when this line isn't included?
    redirect_to restaurant_path(@restaurant), notice: "Date was successfully destroyed."
  
    respond_to do |format|
      format.html { redirect_to restaurant_path(@restaurant), notice: "Date was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Date was successfully destroyed." }
    end
  end

  private

  def line_item_date_params
    params.require(:line_item_date).permit(:date)
  end

  def set_restaurant
    @restaurant = current_company.restaurants.find(params[:restaurant_id])
  end

  def set_line_item_date
    @line_item_date = @restaurant.line_item_dates.find(params[:id])
  end
end
