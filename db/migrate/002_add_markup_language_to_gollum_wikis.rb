class AddMarkupLanguageToGollumWikis < ActiveRecord::Migration
  def self.up
    add_column :gollum_wikis, :markup_language, :string, :default => 'markdown'
  end

  def self.down
    remove_column :gollum_wikis, :markup_language
  end
end
