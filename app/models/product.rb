class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, through: :product_categories

    enum status: { draft: 0, published: 1, archived: 2 }

    has_one_attached :preview_image
    has_many_attached :images
    
    validates :stock, :numericality => { :greater_than_or_equal_to => 0 }
    validates :price, :numericality => { :greater_than => 0 }
end
