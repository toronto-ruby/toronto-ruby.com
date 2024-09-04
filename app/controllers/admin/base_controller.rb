module Admin
  class BaseController < ApplicationController
    http_basic_authenticate_with(
      name: Rails.env.test? ? "admin" : Rails.application.credentials.auth.user,
      password: Rails.env.test? ? "admin" : Rails.application.credentials.auth.password
    )
  end
end
