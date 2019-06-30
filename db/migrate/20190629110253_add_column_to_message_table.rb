class AddColumnToMessageTable < ActiveRecord::Migration[5.2]
  def change
   add_reference :messages,:user
  end
end
