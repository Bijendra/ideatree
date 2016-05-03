class Assignment < ActiveRecord::Base

	belongs_to :user
	has_many :tags
	belongs_to :category
  #has_many :comments

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", home: "620x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/ 
  

  has_attached_file :document
  validates_attachment_content_type :document, :content_type => ["application/pdf","application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "text/plain"]
  
  validates :title, presence: true
  validates :description, presence: true

  attr_accessor
	acts_as_commentable
        acts_as_paranoid

    def count_likes
      likes = Like.where(assignment_id: self.id, status: true).count
    end  

    def count_unlikes
      unlikes = Like.where(assignment_id: self.id, status: false).count
    end  
end