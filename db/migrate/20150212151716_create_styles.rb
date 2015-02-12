class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
    add_column :beers, :style_id, :integer
    
    remove_column :beers, :styles
  end
end
