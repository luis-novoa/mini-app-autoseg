class ListsController < ApplicationController
  before_action :check_permition, only: %i[show]
  def new
    @list = current_user.lists.build
    @list.sublists.build
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      flash.now[:alert] = @list.errors.full_messages
      render :new
    end
  end

  def show
    @list
  end

  def index
    @lists = current_user.lists.order(:description)
  end

  private

  def check_permition
    @list = List.find(params[:id])
    return redirect_to lists_path if @list.parent_list_id || (@list.is_private && @list.user_id != current_user.id)
  end

  def count_sublist_levels(list_params)
    return 0 unless list_params[:sublists_attributes]

    output = []
    list_params[:sublists_attributes].each do |sublist_element|
      output << count_sublist_levels(sublist_element[1]) + 1
    end
    output.max
  end

  def list_params
    sublist_levels = count_sublist_levels(params[:list])
    params_permitted = prepare_sublists_attributes(sublist_levels)
    params.require(:list).permit(*params_permitted)
  end

  def prepare_sublists_attributes(sublist_levels)
    return %i[description is_private] if sublist_levels.zero?

    [:description, :is_private, sublists_attributes: prepare_sublists_attributes(sublist_levels - 1)]
  end
end
