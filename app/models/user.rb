class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :saveds, dependent: :destroy
  has_many :saved_businesses, through: :saveds, source: :business

  has_many :reviews, dependent: :destroy
end
