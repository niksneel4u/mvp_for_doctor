# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  USER_TYPE = { doctor: 'Doctor', patient: 'Patient' }.freeze

  def self.doctor?(current_user)
    current_user.type == User::USER_TYPE[:doctor]
  end
end
