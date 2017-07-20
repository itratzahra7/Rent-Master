class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attached_file :logo, styles: { large: "600x600>", medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/rails.png"
     validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  # validates :name, presence: true
  validates :description, presence: true
  validates :phone, presence: true
  #has_attached_file :logo
  #validates_attachment_presence :logo 
  has_many :users
  has_many :company_industries, :dependent => :destroy
  has_many :industries, :through => :company_industries
  has_many :products, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
