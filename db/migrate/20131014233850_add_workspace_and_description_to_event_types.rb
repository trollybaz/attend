class AddWorkspaceAndDescriptionToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :description, :string
    add_column :event_types, :workspace_id, :integer, null: false
  end
end
