Droplets.new('busix', fetch(:stage)).each do |ip|
  server ip, user: 'root', roles: %w{db app web sidekiq}
end
