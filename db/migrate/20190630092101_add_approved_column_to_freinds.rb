class AddApprovedColumnToFreinds < ActiveRecord::Migration[5.2]
  def change
   add_column :friends,:approved,:boolean,:default=>false
  end
end
