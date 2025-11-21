class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates :movie, presence: true
  validates :comment, length: { minimum: 6 }, presence: true
  validates :movie_id, uniqueness: { scope: :list_id }, presence: true
end
