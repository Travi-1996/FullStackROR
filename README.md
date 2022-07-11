# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



#encryption key

type in terminal >> EDITOR="nano" rails credentials:edit

add these line in the the terminal
active_record_encryption:
  primary_key: NoATlUTtReYEkQkRZsbpQ33MQfnUFZyW
  deterministic_key: eaAsSSacIsMbINrEUlIn603pfccLvaBZ
  key_derivation_salt: b7ke3YX6uqAY2djz517E9NmlRRpKniWG


#implemant redis cache store
add gem file in gemfile
#cache-store
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'

add redis.yml file in config folder
  content>> 
  ----------------------------------------------
  default: &default
  host: 127.0.0.1
  port: 6379

  #development_db
  development:
  <<: *default
  db: 0
  --------------------------------
comment these lines in development.rb file

 <!-- Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = false

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end -->
add these line comment these lines in development.rb file
----------------------------------------------------------------
redis_config = Rails.application.config_for(:redis)
config.cache_store = :redis_cache_store, {url: "redis://#{redis_config['host']}:#{redis_config['port']}/#{redis_config['db']}"}
------------------------------------------------------------------

write cache: >> Rails.cache.write(('users/session/1'), "sdvadsqerwe2314231234", expires_in: 1.minutes)

read cach >> Rails.cache.read("users/session/1")