class AccountController < ApplicationController
    before_action :authenticate_user!

    def account
        Rails.logger.warn("test")
        Rails.logger.warn("Current user: #{current_user.inspect}")
        @recent_searches = current_user.recent_searches.includes(:businesses).order(last_query_date: :desc).limit(3)
        Rails.logger.warn(@recent_searches)
    end
end
