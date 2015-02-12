class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end

    # old styles to database
    ["Weizen", "Lager", "Pale ale", "IPA", "Porter"].each do |stl|
      Style.create name:stl, description:""
    end

    change_table :beers do |t|
      t.rename :style, :old_style
    end

    add_column :beers, :style_id, :integer

    Beer.all.each do |beer|
      style = Style.find_by_name(beer.old_style)
      beer.style_id = style.id
      beer.save
    end

    remove_column :beers, :old_style
  end
end