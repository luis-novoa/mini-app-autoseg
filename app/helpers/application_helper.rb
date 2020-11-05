module ApplicationHelper
  def navbar
    return unless current_user

    render partial: 'layouts/navbar'
  end
end
