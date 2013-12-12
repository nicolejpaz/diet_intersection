class AddMetaValuesToDiet < ActiveRecord::Migration
  def change
    add_column :diets, :meta_number, :string
  end
end
