class NewBgJob
  include Sidekiq::Job

  def perform(user_id)
    # Do something
    user = User.find(user_id)
    user.update(address: "chennai new")
  end
end
