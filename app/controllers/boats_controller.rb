class BoatsController < ApplicationController
  #  skip_before_action :authenticate_user!, only: :index
    before_action :set_boat, only: [:show, :edit, :update, :destroy]
    # before_action :authentification
    def index
      if params[:query].present?
        @query = params[:query]
        @boats = Boat.where("category ILIKE ?", "%#{params[:query]}%")
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
      @boat.user = current_user
      if @boat.save
        redirect_to boat_path(@boat)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @boats = Boat.all
      @user = @boat.user
      @reservation = Reservation.new
      @markers = @boats.geocoded.map do |boat|
        {
          lat: boat.latitude,
          lng: boat.longitude
        }
      end
    end

    def edit
    end

    def  update
      if @boat.update(boat_params)
        redirect_to boat_path(@boat)
      else
        render :new, status: :unprocessable_entity
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

    def perform_search(query)
      category_query = query["category"].downcase if query.present? && query["category"].present?
      Boat.where("lower(category) = ?", category_query)
    end

    private
    def set_boat
     @boat = Boat.find(params[:id])
    end

    def boat_params
      params.require(:boat).permit(:category, :name, :address, :description, :price, :photo, :photos, :longitude, :latitude)
    end
end
