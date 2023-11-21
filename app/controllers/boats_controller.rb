class BoatsController < ApplicationController
  before_action :set_boat, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @query = params[:query]
      @boats = Boat.where("name ILIKE ?", "%#{params[:query]}%")
      # Prévention des injections SQL et des erreurs de base de données pour
      # les caractères inconnus
    else
      @boats = Boat.all
    end
  end

  def search
    if params[:query].present?
      @query = params[:query].downcase
      @boats = Boat.where("category ILIKE ?", "%#{@query}%")
      # Prévention des injections SQL et des erreurs de base de données pour
      # les caractères inconnus
    else
      redirect_to boats_path
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
    # Mettez votre logique d'affichage de la page de détails du bateau ici
  end

  def edit
    # Mettez votre logique d'édition du bateau ici
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

  private

  def set_boat
    @boat = Boat.find(params[:id])
  end

  def boat_params
    params.require(:boat).permit(:category, :name, :address, :description, :price)
  end
end
