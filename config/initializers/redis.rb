# This is for heroku so the asset precompile does not fail
Rails.application.config.cache_store = :redis_store if ENV['REDISCLOUD_URL']
