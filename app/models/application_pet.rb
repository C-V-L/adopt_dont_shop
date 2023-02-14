class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum app_pet_status: ["Pending", "Accepted", "Rejected"]

  def self.find_by_app_pet(app_id, pet_id)
    where(application_id: app_id, pet_id: pet_id).first
  end

  def self.find_by_app(app_id)
    where(application_id: app_id)
  end

  def join_with_pets
    require 'pry'; binding.pry
  end
end