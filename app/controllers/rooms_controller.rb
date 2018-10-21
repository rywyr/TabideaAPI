class RoomsController < ApplicationController
  def show
    @mmos = Mmo.all
    render:json => @mmos
  end
end
