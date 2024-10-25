class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :image, presence: true
  validates :description, presence: true , length: { minimum: 10 }
  before_destroy :purge_image

  private

  def purge_image
    image.purge if image.attached?
  end
end
