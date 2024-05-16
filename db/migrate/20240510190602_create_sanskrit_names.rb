class CreateSanskritNames < ActiveRecord::Migration[7.1]
  def change
    create_table :sanskrit_names do |t|
      t.string :name
      t.references :yoga_pose, null: false, foreign_key: true

      t.timestamps
    end
  end
end
