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
    @boats = if params[:query].present?
            perform_search(params[:query])
    else
      Boat.all
    end
    render :index
  end

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.new(boat_path)
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


  private
  def set_boat
    @boat = Boat.find_by(id: params[:id])
    unless @boat
      flash[:alert] = "Boat not found"
      redirect_to root_path
   end

   def boat_params
    params.require(:boat).permit(:category, :name, :address, :description, :price)
  end

  def perform_search(query)
    category_query = query["category"].downcase if query.present? && query ["category"].present?
    Boat.where("lower(category) = ?, category_query")

  end
end
end
