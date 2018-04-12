class AddCreatorIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :creator_id, :integer
  end
end
