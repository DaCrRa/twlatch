class HomeController < ApplicationController
  def show
    if current_user.present?
      @tweets = current_user.ttweets.all
      @messages = current_user.tmessages.all
    end
  end

  def pair
    unless params[:token].blank?
      latch = Latch.new(Rails.application.config.latch_id, Rails.application.config.latch_secret)
      response = latch.pair params[:token]
      if !response.nil? &&
          !response.data.nil? &&
          !response.data['accountId'].blank?

        current_user.latch_id = response.data['accountId']
        timeline = current_user.get_client.user_timeline
        if timeline.present? && timeline.first.present?
          current_user.last_tweet = current_user.get_client.user_timeline.first.id
          current_user.last_pm = current_user.get_client.direct_messages_sent.first.id
        else
          current_user.last_tweet = 0
          current_user.last_pm = 0
        end
        current_user.save
        redirect_to root_path
      else
        redirect_to controller: 'home', action: 'show', e: 'pair'
      end
    else
      redirect_to root_path
    end
  end

  def unpair
    latch = LatchSdk.new(Rails.application.config.latch_id, Rails.application.config.latch_secret)
    response = latch.opStatus(current_user.latch_id, Rails.application.config.latch_unpair_id)
    # Latch off = Unpair is not allowed
    if response.present? && response.data['operations'][Rails.application.config.latch_unpair_id]['status'].present? &&
        response.data['operations'][Rails.application.config.latch_unpair_id]['status'].to_s == 'off'

      redirect_to controller: 'home', action: 'show', e: 'unpair'
    else
      latch.unpair current_user.latch_id
      current_user.latch_id = ""
      current_user.save
      redirect_to root_path
    end
  end
end
