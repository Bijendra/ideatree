class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/  
  
  has_many :assignments      
  has_many :comments
  has_many :likes
  has_many :follows
  
  acts_as_paranoid

  validates_format_of :email, :with => /\A[\w+\-.]+@shoretel.com/i, :message => "Email is invalid, only Shoretel Email is allowed"

  attr_accessor :get_display_name

  def get_display_name
    #pry.bind
    name = self.name 
    name = self.first_name if name.blank?
    name = self.last_name if name.blank?
    name = self.email.split('@')[0]
  end 	
end
