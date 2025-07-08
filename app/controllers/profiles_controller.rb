class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated!"
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :zipcode, :address, :phone, :country, :state, :city, :date_of_birth, :photo)
  end
end
