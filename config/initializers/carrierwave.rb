CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                 => ENV['AWS_REGION']   # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = ENV['AWS_S3_BUCKET']   # required
  # this is secure by default
  config.fog_use_ssl_for_aws = false
end