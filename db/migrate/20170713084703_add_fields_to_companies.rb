class AddFieldsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :name, :string
    add_column :companies, :phone, :decimal
    add_column :companies, :description, :text
  end
end
