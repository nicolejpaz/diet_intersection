class CreateDiets < ActiveRecord::Migration
  def change
    create_table :diets do |t|
      t.string "name"

      t.timestamps
    end
  end
end
