class AddWorskspaceToPerson < ActiveRecord::Migration
  def change
    add_column :people, :workspace_id, :integer, null: false
  end
end
