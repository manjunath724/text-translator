class Variants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants, id: false do |t|
      t.integer :dictionary_a_id, null: false
      t.integer :dictionary_b_id, null: false
    end
    add_index :variants, :dictionary_a_id
    add_index :variants, :dictionary_b_id
  end
end
