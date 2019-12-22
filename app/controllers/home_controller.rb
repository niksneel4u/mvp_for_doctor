class HomeController < ApplicationController
  def index
    if current_user.type == User::USER_TYPE[:doctor]
      redirect_to doctors_index_path
    else
      redirect_to patients_index_path
    end
  end
end
