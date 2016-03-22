#Override the registrations_controller from Devise. Inherit from "Devise::RegistrationsController"
#with 2 private methods to override "sign_up_params" & "account_update_params"
class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password, :avatar)
  end

end