require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = "*"

  # Getting PG::Error's (postgres errors) if these aren't here.
  # See https://devcenter.heroku.com/articles/forked-pg-connections
  Resque.before_fork do
    defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
  end
  Resque.after_fork do
    defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
  end

end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"