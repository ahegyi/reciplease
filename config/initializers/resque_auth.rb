require 'resque/server'

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  password == ENV['RESQUE_WEB_AUTH']
end