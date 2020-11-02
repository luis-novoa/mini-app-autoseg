class ListsController < ApplicationController
  def new
    @new_list = current_user.lists.build
    2.times { @new_list.tasks.build }
    2.times { @new_list.sublists.build }
    @new_list
  end

  def show; end

  def index; end
end
