require 'rails_helper'

RSpec.describe 'Authorization', type: :feature do
  subject { page }

  context 'user not logged' do
    it "can't access list index" do
      visit lists_path
      is_expected.to have_current_path(new_user_session_path)
    end

    it "can't access new list page" do
      visit new_list_path
      is_expected.to have_current_path(new_user_session_path)
    end
  end
end
