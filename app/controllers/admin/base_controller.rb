module Admin
  class BaseController < ApplicationController
    http_basic_authenticate_with(
      name: Rails.env.production? ? Rails.application.credentials.auth.user : 'admin',
      password: Rails.env.production? ? Rails.application.credentials.auth.password : 'admin'
    )
  end
end
