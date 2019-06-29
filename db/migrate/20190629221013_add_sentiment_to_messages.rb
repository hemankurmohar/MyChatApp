class AddSentimentToMessages < ActiveRecord::Migration[5.2]
  def change
   add_column :messages,:sentiment,:integer
  end
end
