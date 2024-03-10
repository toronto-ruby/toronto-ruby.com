Honeybadger.configure do |config|
  config.api_key = Rails.application.credentials.honeybadger
  # config.exceptions.ignore += [CustomError]
end
