class Album < ApplicationRecord
  after_save :confirmation_email
  belongs_to :user
  has_and_belongs_to_many :tags
  has_one_attached :cover_image
  has_many_attached :images
  validates :title,:description,presence:true
  def tagged=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(album_tags: name.strip).first_or_create!
    end
  end

  def tagged
    tags.map(&:album_tags).join(", ")
  end
  private
    def confirmation_email
      ApplicationMailer.welcome_email(user).deliver_now
    end
end
