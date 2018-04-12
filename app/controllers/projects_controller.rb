
class ProjectsController < ApplicationController
  def index
    puts 'getting all'
    @user = User.find(session[:current_user_id])
    @projects = @user.projects
    @projects.each do |project|
      # project1=@user.projects.find()
      #    puts project1._id
      puts project._id.to_s
    end
    render json: @projects
  end

  def create
    puts 'session[user_id]:'
    puts session[:current_user_id]

    @user = User.find(session[:current_user_id])
    @project = @user.projects.create(projects_params)
    if @user.save
      isSuccess = true
      ahash = { 'isSuccess' => true, 'project' => @project }
      puts ahash
      render json: ahash
    # Article对象也可以redirectto showpage
    else
      render plain: @project
    end
  end

  def update
    # @project = Project.find((params[:_id].__mongoize_object_id__))
    @user = User.find(session[:current_user_id])
    id = BSON::ObjectId.from_string(params[:id])
    @project = @user.projects.find(id)

    if @project.update(projects_params)
        isSuccess=true
    else
        isSuccess=false
    end 
    render json:isSuccess
  end
  def destroy 
    @user = User.find(session[:current_user_id])
    id = BSON::ObjectId.from_string(params[:id])
    @project = @user.projects.find(id)
    if @project.destroy
        isSuccess=true
    else
        isSuccess=false
    end 
    render json:isSuccess
  end
  
####   params validation
  def id_params
    params.require(:_id).permit(:$oid)
  end

  def projects_params
    params.require(:project).permit(:project_name, :project_create_time, :isStarred, :isActive)
  end

  def users_params
    params.require(:user).permit(:_id, :psw)
  end
end
