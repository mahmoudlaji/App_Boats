class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end

  def create
    @boat = Boat.find(params[:boat_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.boat = @boat
    @reservation.user = current_user
    if @reservation.save
      redirect_to boat_path(@boat)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :last_name, :email, :start_date, :end_date)
  end
end
