require 'rails_helper'

RSpec.describe 'Public lists/index.html.erb', type: :feature do
  subject { page }
  let!(:personal_public_list) { create(:list) }
  let!(:other_public_list) { create(:list) }
  let(:user) { personal_public_list.user }
  let!(:personal_private_list) { create(:list, is_private: true, user: user) }
  let!(:other_private_list) { create(:list, is_private: true) }
  let!(:sublist) { create(:sublist, parent_list: other_public_list) }

  before(:each) do
    login(user)
    click_on 'Public Lists'
  end

  it { is_expected.to have_link href: list_path(personal_public_list) }
  it { is_expected.to have_link href: list_path(other_public_list) }
  it { is_expected.to have_no_link href: list_path(personal_private_list) }
  it { is_expected.to have_no_link href: list_path(other_private_list) }
  it { is_expected.to have_no_link href: list_path(sublist) }
end
