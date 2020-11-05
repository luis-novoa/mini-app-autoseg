require 'rails_helper'

RSpec.describe 'Personal lists/index.html.erb', type: :feature do
  subject { page }
  let!(:sublist) { create(:sublist) }
  let!(:personal_list) { sublist.parent_list }
  let(:user) { personal_list.user }
  let!(:personal_list2) { create(:list, user: user) }
  let!(:other_list) { create(:list) }

  before(:each) do
    login(user)
    click_on 'My Lists'
  end

  it { is_expected.to have_link href: list_path(personal_list) }
  it { is_expected.to have_link href: list_path(personal_list2) }
  it { is_expected.to have_no_link href: list_path(other_list) }
  it { is_expected.to have_no_link href: list_path(sublist) }
end
