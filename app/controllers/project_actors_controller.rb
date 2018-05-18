class ProjectActorsController < ApplicationController
    def index
        puts 'getting all project actors'
        id = BSON::ObjectId.from_string(params[:project_id])
        
        @project = Project.find(id)
        @project_actors = @project.project_actors
        @project_actors.each do |project_actor|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts project_actor._id.to_s
       end
       ahash = { 'project' => @project, 'projects_actors' =>@project_actors }
       puts ahash
       render json: ahash
     end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           id = BSON::ObjectId.from_string(params[:project_id])
           @project = Project.find(id)
           
           @project_actor = @project.project_actors.create(project_actors_params)
           if @project.save
             isSuccess = true
              @added_project_actor = ProjectActor.where(project_id: id).last
             # @added_task_list =@project.task_lists.last
             # ahash = { 'isSuccess' => true, 'task_list' =>@task_list }
             # puts ahash
             puts "create successfully"
             puts @added_project_actor._id
   
             @array = Array.new
             @array.push(@project_actor)
             
             render json:@project_actor
           # Article对象也可以redirectto showpage
           else
             render plain: @project_actor
           end
         end
         def update
           # @project = Project.find((params[:_id].__mongoize_object_id__))
           # @user = User.find(session[:current_user_id])
           id = BSON::ObjectId.from_string(params[:id])
           @project_actor = ProjectActor.find(id)
       
           if @project_actor.update(project_actors_params) 
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         def destroy 
          
           id = BSON::ObjectId.from_string(params[:id])
           @project_actor = ProjectActor.find(id)
           if @project_actor.destroy
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         
         
         def project_actors_params
           params.require(:project_actor).permit(:user_id,:project_id)
         end
end
