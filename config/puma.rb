workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 3)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

lowlevel_error_handler do |ex, env|
  Raven.capture_exception(
      ex,
      :message => ex.message,
      :extra => { :puma => env },
      :culprit => "Puma"
  )
  # note the below is just a Rack response
  [500, {}, ["An error has occurred, and engineers have been informed. Please reload the page. If you continue to have problems, contact David.Huff@computer-critters.com\n"]]
end

