class LoginController < ApplicationController
  def index
    @phone = login_params['phone']
  end

  # login
  # TODO: This is extremely basic prototype ... needs a ton of clean up
  def create
    ls = LoginService.new(login_params['phone'])
    p = { phone: login_params['phone'] }
    url =
      if login_params['phone'] && login_params['code']
        res = ls.validate_code(login_params['code'])
        puts '', '-' * 80, res, '-' * 80, ''
        if res.code == '200'
          # this contains most user fields like:
          # name, phone_number, authentication_token, etc
          session[:current_user] = JSON.parse(res.body)
          '/'
        else
          login_index_path(p)
        end
      else
        res = ls.login
        res.code == '200' ? login_index_path(p) : login_index_path
      end
    redirect_to url
  end

  def logout
    session[:current_user] = nil
    redirect_to login_index_path
  end

  private

  def login_params
    params.permit(:phone, :code)
  end
end
