class CreateLayers < ActiveRecord::Migration[5.0]
  def change
    create_table :layers do |t|
      t.integer :project_id
      t.string  :name
    end
  end
end
