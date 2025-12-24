class RecentSearch < ApplicationRecord
  MAX_PER_USER = 3

  belongs_to :user
  has_many :recently_searched_businesses, dependent: :destroy
  has_many :businesses, through: :recently_searched_businesses

  default_scope { order(last_query_date: :desc) }
  after_commit :enforce_limit, on: :create

  private

  def enforce_limit
    oldSearches = user.recent_searches.offset(MAX_PER_USER)
    oldSearches.destroy_all if oldSearches.exists?
  end
end
