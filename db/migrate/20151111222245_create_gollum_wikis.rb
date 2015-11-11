class CreateGollumWikis < ActiveRecord::Migration
  def change 
    create_table :gollum_wikis do |t|
      t.references :project
      t.string :git_path
    end
  end

  def self.down
    drop_table :gollum_wikis
  end
end
