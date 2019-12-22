# frozen_string_literal: true

class DoctorsController < ApplicationController
  before_action :validate_user
  def index
    @appointments = current_user.appointments
  end

  private

  def validate_user
    return if User.doctor?(current_user)

    redirect_to patients_index_path
  end
end
