class CreateYogaPoses < ActiveRecord::Migration[7.1]
  def change
    create_table :yoga_poses do |t|
      t.text :benefits
      t.string :category
      t.text :description
      t.string :difficulty
      t.string :display_name
      t.string :name
      t.string :image_url
      t.string :video_url

      t.timestamps
    end
  end
end
