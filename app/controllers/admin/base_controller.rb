module Admin
  class BaseController < ApplicationController
    http_basic_authenticate_with name: Rails.application.credentials.auth.user,
                                 password: Rails.application.credentials.auth.password
  end
end
