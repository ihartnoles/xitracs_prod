class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :description
      t.integer :school_id

      t.timestamps
    end
  end
end
