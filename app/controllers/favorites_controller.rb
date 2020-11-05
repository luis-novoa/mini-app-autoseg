class FavoritesController < ApplicationController
  def create
    current_user.favorites.build(list_id: params[:id]).save
    redirect_to list_path(params[:id])
  end

  def index
    @favorites = Favorite.includes(list: :user).where(user_id: current_user.id)
  end

  def destroy
    Favorite.find(params[:id]).destroy
    redirect_to favorites_path
  end
end
