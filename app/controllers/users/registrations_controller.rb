# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_permitted_parameters, only: [:update]

  def new
    @user = User.new
    super
  end

  def update
    super
  end

  def create
    @user = User.new(user_params)
    @user.type = add_type
    add_available_time if doctor?
    @user.save!
    sign_in(@user)
    redirect_to root_path
  rescue Exception => e
    render 'new'
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[first_name last_name specialist available_start_time available_end_time]
    )
  end
  
  def add_available_time
    @user.available_start_time = add_time(7)
    @user.available_end_time = add_time(17)
  end

  def add_time(time)
    Time.now.utc.change(hour: time)
  end

  def doctor?
    params.dig(:role) == '0'
  end

  def add_type
    doctor? ? User::USER_TYPE[:doctor] : User::USER_TYPE[:patient]
  end

  def user_params
    params.require(:user).permit(
      :email, :first_name, :last_name,
      :password,
      :password_confirmation,
      :available_start_time,
      :available_end_time
    )
  end
end
