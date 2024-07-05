class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params[:username])
  end

  def liked
    @user = User.find_by!(username: params[:username])
  end

  def feed
    @user = User.find_by!(username: params[:username])
  end
end
