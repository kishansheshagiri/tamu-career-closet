class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    User.create!(user_params)
    # auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { success:true, message: Message.account_created}
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end