class BoatsController < ApplicationController

    before_action :set_boat, only: [:show, :edit, :update, :destroy]

    def index
      if params[:query].present?
        @query = params[:query]
        @boats = Boat.where("name LIKE ?", "%#{params[:query]}%")
        # Preventing SQL Injection and Database error for
        # unknown characters
      else
      @boats = Boat.all
      end
    end


    def new
      @boat = Boat.new
    end

    def create
      @boat = Boat.new(boat_params)
      if @boat.save
        redirect_to boats_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def  update
      if @boat.update(boat_params)
        redirect_to boat_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @boat.destroy
      redirect_to boats_path
    end

    private
    def set_boat
     @boat = Boat.find(params[:id])
    end

    def boat_params
      params.require(:boat).permit(:category, :name, :address, :description, :price)
    end
end
