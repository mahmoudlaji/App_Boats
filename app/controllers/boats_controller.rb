# app/controllers/boats_controller.rb
class BoatsController < ApplicationController
  before_action :set_boat, only: [:show, :edit, :update, :destroy]

  def index
    @boats = Boat.all
  end

  def new
    @boat = Boat.new
  end

  def show
  end

  def create
    @boat = Boat.new(boat_params)

    if @boat.save
      redirect_to boat_path(@boat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @boat.update(boat_params)
      redirect_to boat_path(@boat)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @boat.destroy
    redirect_to boats_path
  end

  def search
    @boats = if params[:query].present?
               perform_search(params[:query])
             else
               Boat.all
             end
    render :index
  end
  private

  def set_boat
    @boat = Boat.find_by(id: params[:id])

    unless @boat
      flash[:alert] = "Boat not found"
      redirect_to root_path
    end
  end

  def boat_params
    params.require(:boat).permit(:category, :name, :address, :description, :price)
  end

  def perform_search(query)
    category_query = query["category"].downcase if query.present? && query["category"].present?
    Boat.where("lower(category) = ?", category_query)
  end
end
