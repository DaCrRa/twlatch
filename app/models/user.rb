class User < ActiveRecord::Base

  has_many :tmessages
  has_many :ttweets

  def get_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    
    client
  end

  def self.create_from_twitter_auth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create
    user.provider = auth.provider
    user.uid = auth.uid
    user.nickname = auth.info.nickname
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_secret = auth.credentials.secret
    user.save!
    user
  end

end
