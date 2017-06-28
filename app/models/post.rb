class Post < ActiveRecord::Base
  validates :title,:body, presence: true
  belongs_to :user
  delegate :email, to: :user
  has_many :comments,dependent: :destroy

  acts_as_votable

  # extend FriendlyId
  # friendly_id :title, use: :slugged


  def to_param
    "#{id} #{title}".parameterize
  end

  acts_as_taggable
  
end
