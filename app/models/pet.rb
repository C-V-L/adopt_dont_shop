class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets,  dependant: :destroy
  has_many :applications, through: :application_pets
  
  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_pets(pet_name)
    where("name ILIKE ?", "%#{pet_name}%")
  end

  def status(app_id)
    application_pets.where(application_id: app_id).first.app_pet_status
  end
end
