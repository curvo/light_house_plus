class UsersController < ApplicationController
  def show
    @user = User.load(params[:id])
  end
end