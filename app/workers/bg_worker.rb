require 'sidekiq-scheduler'

class BgWorker
  include Sidekiq::Worker

  def perform
    # # Do something
    # user = User.find(user_id)
    # address = user.address + 'new'
    # user.update(address: address)
    puts "Hello world"
  end
end