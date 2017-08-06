class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :answers
  belongs_to :user


  def to_param
    "#{id} #{title}".parameterize
  end
  
end
