module ListsHelper
  def user_links(list)
    unless list.user == current_user
      return tag.span(link_to('Add as Favorite', favorites_path(id: list.id), method: :post))
    end

    links = tag.span(link_to('Edit', edit_list_path(list)))
    links += tag.span(link_to('Delete', list_path(list), method: :delete))
    links
  end

  def display_errors
    return unless flash[:alert]

    render partial: 'errors', locals: { errors: flash[:alert] }
  end

  def render_sublist(sublist)
    return if sublist.empty?

    render partial: 'sublist', locals: { sublist: sublist }
  end

  def render_sublist_form(f, sublist_level_counter)
    return if sublist_level_counter.zero?

    render partial: 'sublist_form', locals: { f: f, counter: sublist_level_counter }
  end
end
