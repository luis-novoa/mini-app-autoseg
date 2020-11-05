require 'rails_helper'

RSpec.describe 'lists/show.html.erb', type: :feature do
  subject { page }
  let!(:list) { create(:list) }
  let(:user) { list.user }
  let!(:sublist) { create(:sublist, parent_list: list) }
  let!(:second_level_sublist) { create(:sublist, parent_list: sublist) }
  let!(:third_level_sublists) { create_list(:sublist, 2, parent_list: second_level_sublist) }

  before(:each) do
    login(user)
    visit list_path(list)
  end

  it { is_expected.to have_text list.description }
  it { is_expected.to have_text sublist.description }
  it { is_expected.to have_text second_level_sublist.description }
  it { is_expected.to have_text third_level_sublists[0].description }
  it { is_expected.to have_text third_level_sublists[1].description }
end
