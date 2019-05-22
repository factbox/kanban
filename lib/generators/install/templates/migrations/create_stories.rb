class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.integer :layer_id
      t.string  :story
    end
  end
end
