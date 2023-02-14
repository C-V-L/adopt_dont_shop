class Admin::ApplicationPetsController < ApplicationController

  def update
    @application_pet = ApplicationPet.find_by_app_pet(params[:id], params[:pet_id])
    @application_pet.update(app_pet_status: params[:status])
  end
end