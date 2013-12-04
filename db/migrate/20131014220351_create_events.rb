class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :workspace_id
      t.integer :event_type_id

      t.timestamps
    end
  end
end
