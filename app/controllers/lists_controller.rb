class ListsController < ApplicationController
  def new
    @new_list = current_user.lists.build
    @new_list.sublists.build
  end

  def show; end

  def index; end
end
