class CreateNewhiredoctypes < ActiveRecord::Migration
  def change
    create_table :newhiredoctypes do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
