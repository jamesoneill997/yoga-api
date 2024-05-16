class AddNamesToYogaPoses < ActiveRecord::Migration[7.1]
  def change
    add_reference :yoga_poses, :alternative_name, null: false, foreign_key: true
    add_reference :yoga_poses, :sanskrit_name, null: false, foreign_key: true
  end
end
