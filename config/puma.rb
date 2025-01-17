# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch('PORT', 3000) if ENV.fetch('RAILS_ENV', 'development') == 'development'

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch('RAILS_ENV', 'development')

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

# State path for control program (pumactl) to control puma process
state_path ENV.fetch('STATEFILE', 'tmp/sockets/puma.state')

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

prune_bundler

unless ENV.fetch('RAILS_ENV', 'development') == 'development'
  require 'puma/daemon'

  # Specifies the number of `workers` to boot in clustered mode.
  # Workers are forked web server processes. If using threads and workers together
  # the concurrency of the application would be max `threads` * `workers`.
  # Workers do not work on JRuby or Windows (both of which do not support
  # processes).
  #
  workers ENV.fetch('WEB_CONCURRENCY', 4)

  # Use the `preload_app!` method when specifying a `workers` number.
  # This directive tells Puma to first boot the application and load code
  # before forking the application. This takes advantage of Copy On Write
  # process behavior so workers use less memory.
  #
  preload_app!

  shared_dir = "/home/ubuntu/my-blog/shared"

  # Control program(pumactl) socket path
  activate_control_app "unix://#{shared_dir}/#{ENV.fetch("CONTROLFILE", "tmp/sockets/pumactl.sock")}", no_token: true

  # Set up socket location
  bind "unix://#{shared_dir}/tmp/sockets/puma.sock"

  # Logging
  stdout_redirect "#{shared_dir}/log/puma.log", "#{shared_dir}/log/puma.error.log", true

  # Fork new workers from additional workers instead of main process
  fork_worker

  on_worker_boot do
    # Worker specific setup for Rails 4.1+
    # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
    ActiveRecord::Base.establish_connection
  end

  daemonize
end
