class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	 t.references :company, add_index: true
    end
  end
end
