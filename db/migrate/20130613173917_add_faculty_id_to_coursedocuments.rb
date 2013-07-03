class AddFacultyIdToCoursedocuments < ActiveRecord::Migration
  def change
    add_column :coursedocuments, :faculty_id, :integer
  end
end
