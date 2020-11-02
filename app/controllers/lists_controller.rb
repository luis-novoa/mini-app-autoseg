class ListsController < ApplicationController
  def new
    @new_list = current_user.lists.build
    @new_list.tasks.build
  end

  def show; end

  def index; end
end
