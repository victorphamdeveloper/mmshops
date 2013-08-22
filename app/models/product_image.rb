class ProductImage < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :product
  has_attached_file :image,
    :styles => {
      :thumb=> "100x100#",
      :small  => "300x300>",
      :large => "600x600>"
        }
  attr_accessible :product_id, :image
end
