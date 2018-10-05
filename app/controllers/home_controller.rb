class HomeController < ApplicationController
  def top
    @user = User.all
  end

  def edit
      @user = User.find_by(name: params[:peter])
  end
end
