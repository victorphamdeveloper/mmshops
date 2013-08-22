# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#  name        :string(255)
#  price       :decimal(, )
#  description :text
#  no_of_likes :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :seller, class_name: "Seller", foreign_key: :user_id
  belongs_to :category	
  has_many :line_items
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images, :allow_destroy => true


  attr_accessible :category_id, :description, :name, :no_of_likes, :price, :user_id, :location, :avatar, :product_images_attributes

  validates :name, presence: true
  validates :location, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
end
