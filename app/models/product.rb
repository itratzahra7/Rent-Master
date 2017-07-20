class Product < ActiveRecord::Base
	 belongs_to :company, :counter_cache => true
	 has_attached_file :product_image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }, default_url: "/images/:style/missing.png"
     validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\z/
end
