module Retrospect
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__) + "/../.."
    enable :static, :sessions
    
    not_found do
      status 404
      show :not_found, :title => "Page not found"
    end
    
    get "/?" do
      @projects = Project.all
    end
    
    get "/new" do
      @project = Project.new
      show :new, :title => ["projects", "new project"]
    end
    
    post "/?" do
      @project = Project.new(params[:project_data])
      
      if @project.save
        redirect project_url(@project).to_s
      else
        show :new, :title => ["projects", "new project"]
      end
    end
    
    get "/:project" do
      show :project, :title => ["projects", current_project.name]
    end
    
    helpers do
      def show(view, options={})
        @title = breadcrumbs(*options[:title])
        haml view
      end
    end
  end
end
