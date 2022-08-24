class LoginController < ApplicationController
  def index
  end

  # login
  def create
    @bob = 'jim'
    @res = LoginService.new(login_params['phone']).login
    binding.break
    render :index
    # redirect_to login_index_path
  end

  private

  def login_params
    params.permit(:phone)
  end
end
