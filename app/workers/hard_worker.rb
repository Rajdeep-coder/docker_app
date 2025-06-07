# app/workers/hard_worker.rb
class HardWorker
  include Sidekiq::Worker

  def perform
    puts "Doing work directly from Sidekiq::Worker"
  end
end
