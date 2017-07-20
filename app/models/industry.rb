class Industry < ActiveRecord::Base
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
#devise :database_authenticatable, :registerable,
 #       :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  has_many :company_industries, :dependent => :destroy
  has_many :companies, :through => :company_industries
end