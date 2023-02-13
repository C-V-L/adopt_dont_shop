require 'rails_helper'

RSpec.describe 'admin_shelter show page' do
  describe 'as an admin when I visit the show page' do
    before(:each) do 
      @pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)
      @snugglez = @pound.pets.create!(adoptable: true, age: 2, breed: "Tabby Cat", name: 'Snugglez')
      @khoa = Application.create!(applicant_name: "Khoa", app_street: "Somewhere St", app_city: "Littleton", app_state: "CO", app_zip_code: "80121", description: "I am the best, duh", status: "Pending")
      @khoa.add_pet(@snugglez)
    end

    it 'I should see' do
      visit "/admin/applications/#{@khoa.id}"

      expect(page).to have_content("Pets Applied For\n#{@snugglez.name} Application Status: Pending") 
      click_button "Approve Application"

      expect(current_path).to eq("/admin/applications/#{@khoa.id}")
      expect(page).to have_content("Pets Applied For\n#{@snugglez.name} Application Status: Accepted")
      expect(page).to_not have_button("Approve Application")
    end
  end
end