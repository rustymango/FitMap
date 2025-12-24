class RecentlySearchedBusiness < ApplicationRecord
  belongs_to :recent_search
  belongs_to :business
end
