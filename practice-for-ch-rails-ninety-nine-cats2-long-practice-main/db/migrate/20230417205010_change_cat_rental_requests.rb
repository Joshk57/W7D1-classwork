class ChangeCatRentalRequests < ActiveRecord::Migration[7.0]
  def change

    add_column :cat_rental_requests, :requester_id, :bigint, null: false

    add_index :cat_rental_requests, :requester_id

    add_foreign_key :cat_rental_requests, :users, column: :requester_id
  end
end
