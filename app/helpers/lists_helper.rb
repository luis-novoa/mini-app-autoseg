module ListsHelper
  def display_errors
    return unless flash[:alert]

    render partial: 'errors', locals: { errors: flash[:alert] }
  end

  def render_sublist(sublist)
    return if sublist.empty?

    render partial: 'sublist', locals: { sublist: sublist }
  end
end
