class CreateProfileImages < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_images do |t|
      t.string :img_url
      t.references :user, foreign_key: true , :on_delete => :cascade
      
      t.timestamps
    end
  end
end
