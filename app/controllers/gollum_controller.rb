require_dependency 'user'

class GollumController < ApplicationController
  unloadable

  before_filter :find_project, :find_wiki, :authorize

  def index
    redirect_to :action => :show, :id => "Home"
  end

  def show
    @editable = true
    show_page(params[:id])
  end

  def edit
    @id = params[:id]
    @name, @dir = split_id @id
    @page = @wiki.paged(@name, @dir)
    @content = @page ? @page.text_data : ""
  end

  def update
    id = params[:id]
    name, dir = split_id id
    page = @wiki.paged(name, dir)
    user = User.current

    params[:page][:message] = "gollum"
    commit = { :message => params[:page][:message], :name => user.name, :email => user.mail }

    if page
      @wiki.update_page(page, page.name, page.format, params[:page][:raw_data], commit)
    else
      @wiki.write_page(name, @project.gollum_wiki.markup_language.to_sym, params[:page][:raw_data], commit, dir)
    end

    redirect_to :action => :show, :id => id
  end

  private

  def project_repository_path
    return @project.gollum_wiki.git_path
  end

  def split_id(id)
    if id.include? "/"
      _empty, dir, name = id.split /^(.*)\/(.*)$/ 
    else
        name = id
        dir = ""
    end
    return [name, dir]
  end

  def show_page(id)
    name, dir = split_id id

    if page = @wiki.paged(name, dir)
      @page_id = id
      @page_name = page.name
      @page_title = page.title
      @page_content = page.formatted_data.html_safe
      @page_modified = page.version.authored_date
      @page_author = page.version.author.name
      @page_header = page.header ? page.header.formatted_data.html_safe : ""
      @page_footer = page.footer ? page.footer.formatted_data.html_safe : ""
    elsif gollum_file = @wiki.file(name)
        send_data gollum_file.raw_data, :type => gollum_file.mime_type
    else
      redirect_to :action => :edit, :id => id
    end
  end

  def find_project
    unless params[:project_id].present?
      render :status => 404
      return
    end

    @project = Project.find(params[:project_id])
  end

  def find_wiki
    git_path = project_repository_path

    unless File.directory? git_path
      Rugged::Repository.init_at(git_path, :bare)
    end

    wiki_dir = @project.gollum_wiki.directory
    if wiki_dir.empty?
      wiki_dir = nil
    end

    gollum_base_path = project_gollum_index_path
    @wiki = Gollum::Wiki.new(git_path,
                            :base_path => gollum_base_path,
                            :page_file_dir => wiki_dir)

  end
end
