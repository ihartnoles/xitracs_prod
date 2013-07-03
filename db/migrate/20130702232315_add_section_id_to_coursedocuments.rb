class AddSectionIdToCoursedocuments < ActiveRecord::Migration
  def change
    add_column :coursedocuments, :section_id, :integer
  end
end
