class CreateGoshippos < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_goshippos do |t|
      t.string :shipping_service
      t.decimal :shipping_rate
      t.string :order
      t.string :user
      t.string :product

      t.timestamps
    end
  end
end
