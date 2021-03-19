class Product < ApplicationRecord
    validates :stock, :numericality => { :greater_than_or_equal_to => 0 }
    validates :price, :numericality => { :greater_than => 0 }
end
