require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

# Periodic job every 5s to delete tweets if necessary
# Twitter API rate limit is 180 user_timeline requests every 15 minutes which means
# a max of 1 request every 5s.
# For safety job is scheduled every 7s

s.every '7s' do
  users = User.where.not(latch_id: nil).where.not(latch_id: "")
  users.each do |user|

    twitter_client = user.get_client
    user_timeline = twitter_client.user_timeline
    if user_timeline.present? && user_timeline.first.present?
      last_id = user_timeline.first.id
    else
      last_id = 0
    end

    if last_id > user.last_tweet
      latch = LatchSdk.new(Rails.application.config.latch_id, Rails.application.config.latch_secret)
      response = latch.opStatus(user.latch_id, Rails.application.config.latch_post_id)

      # Latch off = Remove all new tweets
      if response.present? && response.data['operations'][Rails.application.config.latch_post_id]['status'].present? &&
          response.data['operations'][Rails.application.config.latch_post_id]['status'].to_s == 'off'

        tweets_to_delete = Array.new
        user_timeline.each do |tweet|
          if tweet.id > user.last_tweet
            tweets_to_delete.push tweet.id
            ttweet = Ttweet.new
            ttweet.tweet = tweet.full_text
            ttweet.published = Time.now
            user.ttweets << ttweet
          end
        end
        twitter_client.destroy_status tweets_to_delete
      else
        user.last_tweet = last_id
      end
      user.save
    end
  end
end


# Periodic job every 60s to delete sent PM if necessary
# Twitter API rate limit is 15 user_timeline requests every 15 minutes which means
# a max of 1 request every 60s
# For safety job is scheduled every 65s

s.every '65s' do
  users = User.where.not(latch_id: nil).where.not(latch_id: "")
  users.each do |user|

    twitter_client = user.get_client
    user_dms = twitter_client.direct_messages_sent
    if user_dms.present? && user_dms.first.present?
      last_id = user_dms.first.id
    else
      last_id = 0
    end

    if last_id > user.last_pm
      latch = LatchSdk.new(Rails.application.config.latch_id, Rails.application.config.latch_secret)
      response = latch.opStatus(user.latch_id, Rails.application.config.latch_pm_id)
      # Latch off = Remove all new tweets
      if response.present? && response.data['operations'][Rails.application.config.latch_pm_id]['status'].present? &&
          response.data['operations'][Rails.application.config.latch_pm_id]['status'].to_s == 'off'

        pm_to_delete = Array.new
        user_dms.each do |pm|
          if pm.id > user.last_pm
            pm_to_delete.push pm.id
            tmessage = Tmessage.new
            tmessage.message = pm.full_text
            tmessage.published = Time.now
            tmessage.destination = pm.recipient.name
            user.tmessages << tmessage
          end
        end
        twitter_client.destroy_direct_message pm_to_delete
      else
        user.last_pm = last_id
      end
      user.save
    end
  end
end