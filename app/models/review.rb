class Review < ApplicationRecord
  belongs_to :user
  belongs_to :business

  before_validation :normalize_score
  validates :score, presence: true, numericality: true, inclusion: { in: 0.0..5.0 }

  private
  def normalize_score
    return if score.nil?

    self.score = score.to_f.round(1)
  end
end
