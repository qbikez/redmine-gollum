require_dependency 'project'

module GollumProjectModelPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
  end
 
  module InstanceMethods
    def gollum_wiki
      raise "Need project id." unless self.id
      return GollumWiki.where("project_id = ?", self.id) ||
            GollumWiki.new( :project_id => self.id,
                            :git_path => Setting.plugin_redmine_gollum[:gollum_base_path].to_s + "/#{self.identifier}.wiki.git".to_s)
    end
  end
end

