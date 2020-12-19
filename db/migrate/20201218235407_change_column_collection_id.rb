class ChangeColumnCollectionId < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :collection_id
    add_column :comments, :gemstone_id, :integer
  end
end
