require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Twlatch
  class Application < Rails::Application
    config.action_controller.permit_all_parameters = true
  end
end
