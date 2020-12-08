class CreateGemstonesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :gemstones do |t|
      t.string :name
      t.integer :user_id
      t.string :properties
    end
  end
end
