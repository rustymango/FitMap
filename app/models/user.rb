class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :saveds, dependent: :destroy
  has_many :saved_businesses, through: :saveds, source: :business

  has_many :reviews, dependent: :destroy

  has_many :recent_searches, dependent: :destroy
  has_many :recently_searched_businesses, through: :recent_searches
  has_many :recently_viewed_businesses, through: :recently_searched_businesses, source: :business
end
