class AccountController < ApplicationController
    before_action :authenticate_user!

    def account
        @recent_searches = current_user.recent_searches.includes(:businesses).order(last_query_date: :desc).limit(3)
        @saved_businesses = current_user.saved_businesses
    end
end
