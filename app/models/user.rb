class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/  
  
  has_many :assignments      
  has_many :comments
  acts_as_paranoid

  def get_display_name
    name = self.first_name 
    name = self.last_name if name.blank?
    name = self.email.gsub("a").first if name.blank?
  end 	
end
