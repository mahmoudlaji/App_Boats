class BoatsController < ApplicationController
  def edit
  end

  def index
    @boats = Boat.all
  end

  def new
  end

  def show
  end
end
