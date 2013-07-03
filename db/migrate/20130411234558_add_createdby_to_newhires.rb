class AddCreatedbyToNewhires < ActiveRecord::Migration
  def change
  	add_column :newhires, :created_by, :integer

  end
end
