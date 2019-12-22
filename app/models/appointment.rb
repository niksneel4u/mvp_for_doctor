# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  enum status: %i[pending accepted rejected]
  ACCEPTED = 'Accepted'
  REJECTED = 'Rejected'
  PENDING = 'Pending'
  validate :start_time_cannot_be_in_the_past
  validate :time_validate
  validate :start_time_less_then_end_time
  validate :validate_doctor_time

  private

  def validate_doctor_time
    doctor_appointments = User.find_by(id: doctor_id).appointments.where(status: 'accepted')
    doctor_appointments. each do |appointment|
      next unless (start_time..end_time).overlaps?(appointment.start_time..appointment.end_time)
      
      errors.add(:start_time, '^doctor unavailable on this time')
    end
  end

  def start_time_less_then_end_time
    return if start_time < end_time

    errors.add(:start_time, '^end time should be greater then start time')
  end

  def start_time_cannot_be_in_the_past
    return if start_time > Time.now

    errors.add(:start_time, 'should be greater then current time')
  end

  def time_validate
    start_time_validate(start_time, doctor.available_start_time)
    end_time_validate(end_time, doctor.available_end_time)
  end

  def start_time_validate(patient_start_time, doctor_time)
    return if time_only(patient_start_time) >= time_only(doctor_time)

    error_message('start_time')
  end

  def end_time_validate(patient_end_time, doctor_time)
    return if time_only(patient_end_time) <= time_only(doctor_time)

    error_message('end_time')
  end

  def error_message(start_end_time)
    errors.add(start_end_time.to_sym, "^your #{start_end_time} is not suitable for Doctor")
  end

  def time_only(time)
    time.strftime(GlobalConstants::TIME_FORMATE)
  end
end
