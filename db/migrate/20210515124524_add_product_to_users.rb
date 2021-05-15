class AddProductToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :product_id, :integer
  end
end
