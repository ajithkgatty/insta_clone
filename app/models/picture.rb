class Picture < ApplicationRecord
	acts_as_votable
	validates :name, presence: true
	validates :description, presence: true
	validates :image, presence: true
	has_attached_file :image, styles: { medium: "640x" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	belongs_to :user
  	has_many :comments, dependent: :destroy
  	has_many :notifications, dependent: :destroy

  	validates :user_id, presence: true
  	

end
