class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :questions,dependent: :destroy
  has_many :answers,dependent: :destroy

  acts_as_voter

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id'

  has_many :personal_messages, dependent: :destroy

  def self.search(search)
    if search
      where(["email LIKE ?","%#{search}%"])
    else
      all
    end
  end

  # for image upload feature
  has_attached_file :user_image, :styles => {medium: "300*300>", large: "600*600>", thumbnail: "200*250#"}
  validates_attachment_content_type :user_image, content_type: /\Aimage\/.*\z/

  
end
