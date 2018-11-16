class CreateBand < ActiveRecord::Migration[5.2]
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :bands, :name
  end
end
