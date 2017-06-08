class Post < ActiveRecord::Base
  validates :title,:body, presence: true
  belongs_to :user
  delegate :email, to: :user
  has_many :comments,dependent: :destroy

  acts_as_votable

  include Predictable::Item
end
