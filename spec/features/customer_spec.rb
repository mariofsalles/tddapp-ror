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

  scenario 'Register one customer' do

    visit(new_customer_path)
    customer_name = Faker::Name.name
    fill_in('Name', with: customer_name)
    fill_in('Email', with: Faker::Internet.email)
    fill_in('Phone', with: Faker::PhoneNumber.phone_number)
    attach_file('Avatar', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: ['Y','N'].sample)
    click_on('Create Account')
    
    expect(page).to have_content('Customer registered!')
    expect(Customer.last.name).to eq(customer_name)
    end

end
