class AddSourceToGemstonesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :gemstones, :source, :string
  end
end
