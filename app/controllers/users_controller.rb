class UsersController < ApplicationController
  before_action :set_user
  def show
  end

  def liked
  end

  def feed
  end

  def followers
  end

  def following
  end

  private
    def set_user
      @user = User.find_by!(username: params[:username])
    end
end
