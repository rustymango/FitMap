class Business < ApplicationRecord
    has_many :saveds, dependent: :destroy
    has_many :saved_by_users, through: :saveds, source: :user

    has_many :reviews, dependent: :destroy

    def self.search(params, user = nil)
        # Rails.logger.warn("testing ----")
        return [] if params.empty?

        businesses = Business.all
        for param in params
          if param[:services].present?
            businesses = businesses.and(Business.where(
                "services LIKE '%#{param[:services]}%'"
            ))
          else
            businesses = businesses.and(Business.where(param))
          end
        end

        if user
          businesses = businesses
                        .left_joins(:saveds)
                        .left_joins(:reviews)
                        .where("saveds.user_id = ? OR saveds.user_id IS NULL", user[:id])
                        .where("reviews.user_id = ? OR reviews.user_id IS NULL", user[:id])
                        .select("businesses.*, CASE WHEN saveds.id IS NULL THEN FALSE ELSE TRUE END AS saved, reviews.id AS review_id, reviews.score AS review_score, reviews.comments AS review_comments")
        end

        businesses.distinct
    end

    def saved?
      ActiveModel::Type::Boolean.new.cast(self[:saved])
    end

    def user_review
      return nil unless self[:review_id]

      {
        id: self[:review_id],
        score: self[:review_score],
        comments: self[:review_comments]
      }
    end
end
