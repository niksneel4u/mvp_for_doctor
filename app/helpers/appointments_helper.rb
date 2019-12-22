# frozen_string_literal: true

module AppointmentsHelper
  def doctor_id
    new_appointment? ? params.dig(:appointment_id) : @booking.doctor_id
  end

  def new_appointment?
    @booking.new_record?
  end
end
