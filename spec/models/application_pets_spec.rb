require 'rails_helper'

RSpec.describe ApplicationPet, type: :model  do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  before(:each) do
    Pet.destroy_all
    Shelter.destroy_all
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @axel = Application.create!(applicant_name: "Axel", app_street: "959 Broadway", app_city: "Louisville", app_state: "CO", app_zip_code: "80423", description: "I can grow plants, why not raise pets", status:1 )
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @axel.add_pet(@pet_1)
    @axel.add_pet(@pet_2)
  end

  describe 'class methods' do
    it 'should return the ApplicationPet that is associated with the app and pet' do
      expect(ApplicationPet.find_by_app_pet(@axel.id, @pet_1.id)).to be_a ApplicationPet
    end
  end

end