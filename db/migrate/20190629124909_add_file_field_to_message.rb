class AddFileFieldToMessage < ActiveRecord::Migration[5.2]
  def change
   add_column :messages,:is_attachment,:boolean,:default=>false
   add_attachment :messages,:attachment
  end
end
