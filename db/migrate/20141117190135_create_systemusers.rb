class CreateSystemusers < ActiveRecord::Migration
  def change
    create_table :systemusers do |t|

      t.timestamps
    end
  end
end
