class Comment < ApplicationRecord
  # validates :content, presence: true, length: { minimum: 5, maximum: 50 }	
  belongs_to :picture
  belongs_to :user
end
