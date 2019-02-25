require 'rails_helper'

RSpec.feature "Customers", type: :feature do

  scenario 'Verify sign up link' do
    visit(root_path)
    expect(page).to have_link('Sign up')
  end

  scenario 'Verify New Customer link' do
    visit(root_path)
    click_on('Sign up')
    expect(page).to have_content('Customer list')
    expect(page).to have_link('New Customer')
  end

  scenario 'Verify New Customer form' do
    visit(customers_path)
    click_on('New Customer')
    expect(page).to have_content('New Customer')
  end
end
