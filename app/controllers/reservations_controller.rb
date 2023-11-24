class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    render :new
  end

  def create
    @boat = Boat.find(params[:boat_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.boat = @boat
    @reservation.user = current_user
    if check_availability
      flash[:alert] = 'Le bateau n\'est pas disponible aux dates spécifiées.'
      render :new, status: :unprocessable_entity
    elsif @reservation.save
      redirect_to boat_reservation_path(@boat, @reservation), notice: 'La réservation a été créée avec succès.'
    else
      flash.now[:alert] = 'Erreur lors de la création de la réservation.'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path
  end

  private

  def check_availability
    boat_reservations = Reservation.where(boat: params[:boat_id])
    reservation_params = params[:reservation]

    boat_reservations.each do |resa|
      resa_start_date = resa.start_date.to_date
      resa_end_date = resa.end_date.to_date

      input_start_date = Date.parse(reservation_params[:start_date])
      input_end_date = Date.parse(reservation_params[:end_date])

      if (resa_start_date <= input_start_date && input_start_date <= resa_end_date) ||
         (resa_start_date <= input_end_date && input_end_date <= resa_end_date) ||
         (input_start_date <= resa_start_date && resa_end_date <= input_end_date)
        return true
      end
    end
    return false
  end

  def reservation_params
    params.require(:reservation).permit(:name, :last_name, :email, :start_date, :end_date, :boat_id)
  end

end
