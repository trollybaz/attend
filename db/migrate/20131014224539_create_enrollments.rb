class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :person_id
      t.integer :event_type_id

      t.timestamps
    end
  end
end
