class AddDietFlag < ActiveRecord::Migration
  def change
    add_column :diets, :diet_type, :string
  end
end
