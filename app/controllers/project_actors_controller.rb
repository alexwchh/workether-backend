class ProjectActorsController < ApplicationController
    def index
        puts 'getting all project actors'
        id = BSON::ObjectId.from_string(params[:project_id])
       
        @project = Project.find(id)
        @project_actors = @project.project_actors
        @project_actors.each do |project_actor|
          @actor = User.find(project_actor.user_id)
          
          project_actor.update_attributes!(
            user_name: @actor.name,
            email: @actor.email
          )
          # project_actor.email = @actor.email;
          # project_actor.name = @actor.name;

         # project1=@user.projects.find()
         #    puts project1._id 
         puts project_actor._id.to_s
       end
       ahash = { 'project' => @project, 'project_actors' =>@project_actors }
       puts ahash
       render json: ahash
     end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           id = BSON::ObjectId.from_string(params[:project_id])          
           @project = Project.find(id)
           puts @project._id
           @project_actor = @project.project_actors.create(project_actors_params)
           if @project.save
              # userId = BSON::ObjectId.from_string(params[:user_id) 
              #   @user = User.find(userId)
              #   @user.projects.create(@project)

             isSuccess = true
              @added_project_actor = ProjectActor.where(project_id: id).last
          
             puts "create successfully"
             puts @added_project_actor._id
   
            #  @array = Array.new
            #  @array.push(@project_actor)
             
             render json:@project_actor
           # Article对象也可以redirectto showpage
           else
             render plain: @project_actor
           end
         end
         def create_by_group
          id = BSON::ObjectId.from_string(params[:project_id])          
           @project = Project.find(id)
           @add_project_actors = Array(params[:project_actors])
          # hash= @add_project_actors.to_h
           puts @add_project_actors
          
           params[:project_actors].each do |value|
            project_actors_params1
            @project_actors = @project.project_actors.create(value.to_h)
           @project.save
           end
          #  @project_actors = @project.project_actors.create(project_actors_group_params)
          #  @project.save
          #  @add_project_actors.each do |actor|
          #   @project_actor = @project.project_actors.create(actor)
          #   @project.save
          #   end

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
           params.require(:project_actor).permit(:_id,:user_id,:project_id,:email,:user_name)
         end
        
         def project_actors_group_params
          params.require(:project_actors).each do |p|
            ActionController::Parameters.new(p).permit(:_id,:user_id,:project_id,:email,:user_name)
          end
        end

end
