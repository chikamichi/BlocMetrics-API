class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201
    else
      render json: {}, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:token)
  end
end
