class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :ui]

  def home
    if user_signed_in?
      redirect_to dash_path
    end
  end

  def ui
  end

  def dash
    @navbar_render = true
    @user = current_user
  end

  def info
    @navbar_render = true
    @user = current_user
  end


end
