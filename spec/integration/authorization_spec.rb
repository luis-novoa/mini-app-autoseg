require 'rails_helper'

RSpec.describe 'Authorization', type: :feature do
  subject { page }

  context 'user not logged' do
    it 'can access log in page' do
      visit new_user_session_path
      is_expected.to have_current_path(new_user_session_path)
    end

    it 'can access sign up page' do
      visit new_user_registration_path
      is_expected.to have_current_path(new_user_registration_path)
    end

    it "can't access lists index page" do
      visit lists_path
      is_expected.to have_current_path(new_user_session_path)
    end

    it "can't access new list page" do
      visit new_list_path
      is_expected.to have_current_path(new_user_session_path)
    end

    it "can't access list show page" do
      visit list_path(create(:list))
      is_expected.to have_current_path(new_user_session_path)
    end

    it "can't access favorites index page" do
      visit favorites_path
      is_expected.to have_current_path(new_user_session_path)
    end
  end

  context 'logged user' do
    let(:list) { create(:list) }
    before(:each) do
      login(list.user)
    end
    it "can't access log in page" do
      visit new_user_session_path
      is_expected.to have_current_path(root_path)
    end

    it "can't access sign up page" do
      visit new_user_registration_path
      is_expected.to have_current_path(root_path)
    end

    it 'can access lists index page' do
      visit lists_path
      is_expected.to have_current_path(lists_path)
    end

    it 'can access new list page' do
      visit new_list_path
      is_expected.to have_current_path(new_list_path)
    end

    it 'can access list show page' do
      visit list_path(list)
      is_expected.to have_current_path(list_path(list))
    end

    it 'can access favorites index page' do
      visit favorites_path
      is_expected.to have_current_path(favorites_path)
    end
  end
end
