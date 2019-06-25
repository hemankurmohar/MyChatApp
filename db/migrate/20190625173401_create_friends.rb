class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.bigint :user_1_id
      t.bigint :user_2_id
      # t.references :user, foreign_key: true, column: :user_1, index: { name: 'index name1' }
      # t.references :user, foreign_key: true, column: :user2, index: { name: 'index name1' }
       t.boolean :block

      t.timestamps
    end
    add_foreign_key :friends,:users,column: :user_1_id, index: { name: 'index name1' }
    add_foreign_key :friends,:users,column: :user_2_id, index: { name: 'index name2' }

  end
end
