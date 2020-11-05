module ListsHelper
  def user_links(list)
    return unless list.user == current_user

    tag.span(link_to('Edit', edit_list_path)) + tag.span(link_to('Delete', list_path(list), method: :delete))
  end

  def display_errors
    return unless flash[:alert]

    render partial: 'errors', locals: { errors: flash[:alert] }
  end

  def render_sublist(sublist)
    return if sublist.empty?

    render partial: 'sublist', locals: { sublist: sublist }
  end
end
