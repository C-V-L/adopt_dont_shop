class Admin::ApplicationPetsController < ApplicationController

  def update
    @application = Application.find(params[:id])
    @application_pet = ApplicationPet.find_by_app_pet(params[:id], params[:pet_id])
    @application_pet.update(app_pet_status: params[:status].to_i)
    redirect_to "/admin/applications/#{@application.id}"
  end
end