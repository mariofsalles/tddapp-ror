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

  scenario 'Sad path - invalid register' do
    visit(new_customer_path)
    click_on('Create Account')
    expect(page).to have_content("can't be blank")      
  end

  scenario 'Show one customer' do
    customer = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y','N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )
    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)

  end

  scenario 'Testing list of customer' do
    customer1 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y','N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )
    customer2 = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y','N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )
    visit(customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
    # expect(page).to have_content(customer1.email).and have_content(customer2.email)
    # expect(page).to have_content(customer1.phone).and have_content(customer2.phone)

  end

  scenario 'Update one customer' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y','N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )
    new_name = Faker::Name.name
    visit(edit_customer_path(customer.id))
    fill_in('Name', with: new_name)
    click_on('Update Customer')

    expect(page).to have_content('Customer updated complete!')
    expect(page).to have_content(new_name)
  end

  scenario 'Testing show-link' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y','N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )

    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[2]/a').click
    expect(page).to have_content('Show Customer')
  end

  scenario 'Testing edit-link' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y','N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )

    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[3]/a').click
    expect(page).to have_content('Customer edit')
  end

  scenario 'Delete one customer', :js => true do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y','N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/avatar.png"
    )
    visit(customers_path)
    find(:xpath, '/html/body/table/tbody/tr[1]/td[4]/a').click
    sleep 5
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content('Customer delete with success')

  end

end

