class DropSpreeGoshippo < ActiveRecord::Migration[6.1]
  def up
  	drop_table :spree_goshippos
  end
end
