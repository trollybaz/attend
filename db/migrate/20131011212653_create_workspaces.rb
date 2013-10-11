class CreateWorkspaces < ActiveRecord::Migration
  def change
    create_table :workspaces do |t|

      t.timestamps
    end
  end
end
