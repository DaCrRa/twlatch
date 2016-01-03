Twlatch::Application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.twitter_key = "TWITTER_KEY"
  config.twitter_secret = "TWITTER_SECRET"
  config.latch_id = "LATCH_APP_ID"
  config.latch_secret = "LATCH_SECRET"
  config.latch_post_id = "LATCH_OPERATION_POST_TWEETS_ID"
  config.latch_pm_id = "LATCH_OPERATION_PRIVATE_MESSAGES_ID"
  config.latch_unpair_id = "LATCH_OPERATION_UNPAIR_ID"
end
