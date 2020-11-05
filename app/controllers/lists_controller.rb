class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit]
  before_action :check_privacy, only: %i[show]
  before_action :confirm_user, only: %i[edit]

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
    @lists = fetch_lists(params[:scope])
    @lists
  end

  def edit; end

  private

  def check_privacy
    redirect_to lists_path if @list.is_private && @list.user_id != current_user.id
  end

  def confirm_user
    redirect_to lists_path unless @list.user_id == current_user.id
  end

  def count_sublist_levels(list_params)
    return 0 unless list_params[:sublists_attributes]

    output = []
    list_params[:sublists_attributes].each do |sublist_element|
      output << count_sublist_levels(sublist_element[1]) + 1
    end
    output.max
  end

  def fetch_lists(param)
    return current_user.lists.order(:description) unless param

    list = List.includes(:user).where(is_private: false).order(:description)
    list.where.not(user_id: nil)
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

  def set_list
    @list = List.find(params[:id])
    redirect_to lists_path if @list.parent_list_id
  end
end
