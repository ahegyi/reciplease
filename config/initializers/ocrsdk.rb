OCRSDK.setup do |config|
  config.application_id = ENV['ABBYY_APP_ID']
  config.password = ENV['ABBYY_APP_PASSWORD']

  # How much time in seconds wait between requests
  config.default_poll_time = 3 # default

  # How many times retry before rendering request as failed
  config.number_or_retries = 3 # default
  # How much time wait before retries
  config.retry_wait_time   = 3 # default
end