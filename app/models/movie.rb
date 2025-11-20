class Movie < ApplicationRecord
  has_many :bookmarks;
  has_many :lists, through: :bookmarks;
  validates :overview, presence: true;
  validates :title, uniqueness: true;
  validates :title, presence: true
end
