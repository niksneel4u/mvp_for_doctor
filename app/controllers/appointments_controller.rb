# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :validate_user_patient, only: [:create]
  before_action :validate_user_doctor, only: %i[reject accept]
  def booking
    @booking = Appointment.new
  end

  def create
    @booking = current_user.appointments.new(booking_params)
    @booking.doctor_id = params.dig(:doctor_id).to_i
    change_date
    @booking.save!
    redirect_to patients_index_path
  rescue Exception => e
    params[:appointment_id] = @booking.doctor_id
    render 'booking'
  end

  def reject
    change_status(2)
  end

  def accept
    change_status(1)
  end

  private

  def change_date
    date = params.dig(:appointment, :date).to_date
    @booking.start_time = @booking.start_time.change(year: date&.year, month: date&.month, day: date.day)
    @booking.end_time = @booking.end_time.change(year: date&.year, month: date&.month, day: date.day)
  end

  def change_status(status)
    appointment = Appointment.find_by(id: params.dig(:appointment_id))
    unless appointment.update(status: status)
      flash[:error] = 'you already have an appointment on this time'
    end
    redirect_to doctors_index_path
  end

  def booking_params
    params.require(:appointment).permit(
      :start_time, :end_time
    )
  end

  def validate_user_patient
    return unless User.doctor?(current_user)

    redirect_to doctors_index_path
  end

  def validate_user_doctor
    return if User.doctor?(current_user)

    redirect_to patients_index_path
  end
end
