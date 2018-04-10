class CreateBooksUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :books_users do |t|
      t.integer :book_id
      t.integer :user_id
    end
  end
end
