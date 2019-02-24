require 'rails_helper'

RSpec.feature "Welcome", type: :feature do
  
  scenario 'Show welcome message' do
    visit (root_path)
    expect(page).to have_content('Welcome')
  end 
  
  scenario 'Verify signup link' do
    
  end

end
