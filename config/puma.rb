workers ENV.fetch('PUMA_WORKERS', '2').to_i
threads_count = ENV.fetch('PUMA_THREADS', '5').to_i
threads threads_count, threads_count

preload_app!

rackup DefaultRackup
port ENV.fetch('PORT', '3000').to_i
environment ENV.fetch('RAILS_ENV', 'development')

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end
