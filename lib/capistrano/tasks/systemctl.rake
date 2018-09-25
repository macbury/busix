namespace :systemctl do
  namespace :puma do
    task :restart do
      on roles(fetch(:puma_role, :app)) do |role|
        sudo :systemctl, 'restart', 'puma'
      end
    end

    task :stop do
      on roles(fetch(:puma_role, :app)) do |role|
        sudo :systemctl, 'stop', 'puma'
      end
    end

    task :start do
      on roles(fetch(:puma_role, :app)) do |role|
        sudo :systemctl, 'start', 'puma'
      end
    end
  end


  namespace :sidekiq do
    task :restart do
      on roles(fetch(:sidekiq_role, :app)) do |role|
        sudo :systemctl, 'restart', 'sidekiq'
      end
    end

    task :stop do
      on roles(fetch(:sidekiq_role, :app)) do |role|
        sudo :systemctl, 'stop', 'sidekiq'
      end
    end

    task :start do
      on roles(fetch(:sidekiq_role, :app)) do |role|
        sudo :systemctl, 'start', 'sidekiq'
      end
    end
  end
end
