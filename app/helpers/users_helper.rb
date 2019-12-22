# frozen_string_literal: true

module UsersHelper
  def status(appointment)
    if appointment.pending?
      Appointment::PENDING
    elsif appointment.accepted?
      Appointment::ACCEPTED
    else
      Appointment::REJECTED
    end
  end
end
