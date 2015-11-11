class GollumWiki < ActiveRecord::Base
  unloadable
  belongs_to :project

  def to_key
    name
  end

end
