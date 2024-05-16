class ChangeNamesNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:yoga_poses, :alternative_name_id, true)
    change_column_null(:yoga_poses, :sanskrit_name_id, true)
  end
 end
