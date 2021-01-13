class Product < ApplicationRecord
  has_one_attached :image
  has_many :order_items
end
