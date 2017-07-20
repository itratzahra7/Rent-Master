class AddStatusToIndustries < ActiveRecord::Migration
  def change
    add_column :industries, :status, :string
  end
end
