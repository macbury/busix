web: bin/rails s
worker-single: bin/sidekiq -q versions -q directions -q lines --concurrency 1
worker-multi: bin/sidekiq -q stops -q default --concurrency 10
