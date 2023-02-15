require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    Pet.destroy_all
    Shelter.destroy_all
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @axel = Application.create!(applicant_name: "Axel", app_street: "959 Broadway", app_city: "Louisville", app_state: "CO", app_zip_code: "80423", description: "I can grow plants, why not raise pets", status:1 )
    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @axel.add_pet(@pet_1)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end

  describe '#search_pets' do 
    it 'returns all the pets whose name matches the search' do 
      expect(Pet.search_pets("Clawdia")).to eq [@pet_2]
    end
  end
  
  describe '#status' do
    it 'returns the status of the pet on that application' do
      expect(@pet_1.pet_status(@axel.id)).to eq "Pending"
    end
  end
end
