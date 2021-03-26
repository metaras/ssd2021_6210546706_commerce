class Category < ApplicationRecord
    has_many :product
    has_many :products, through: :product_categories
end
