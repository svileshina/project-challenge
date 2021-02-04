class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user, optional: true

  paginates_per 5
end
