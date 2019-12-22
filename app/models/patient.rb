# frozen_string_literal: true

class Patient < User
  has_many :doctors
  has_many :appointments
end
