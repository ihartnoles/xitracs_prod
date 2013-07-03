class CreateCoursedocuments < ActiveRecord::Migration
  def change
    create_table :coursedocuments do |t|
      t.integer :course_id
      t.integer :semester_id
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
