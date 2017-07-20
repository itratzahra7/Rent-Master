class AddProductsCountToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :products_count, :integer, :default => 0
  end
end
