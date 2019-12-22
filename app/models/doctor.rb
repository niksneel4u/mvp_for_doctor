# frozen_string_literal: true

class Doctor < User
  has_many :patients
  has_many :appointments
  SPECIALIST_TYPE = {
    Dermatologists: 'Dermatologists',
    Endocrinologists: 'Endocrinologists',
    Gastroenterologists: 'Gastroenterologists',
    Internists: 'Internists'
  }.freeze
end
