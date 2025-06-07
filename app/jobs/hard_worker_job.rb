class HardWorkerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Doing hard work at #{Time.current}"
  end
end
