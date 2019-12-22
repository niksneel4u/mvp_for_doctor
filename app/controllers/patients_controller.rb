class PatientsController < ApplicationController
  before_action :validate_user
  def index
    @appointments = current_user.appointments
  end

  private
  
  def validate_user
    return unless User.doctor?(current_user)

    redirect_to doctors_index_path
  end
end
