class AgendasController < ApplicationController
    def index
        puts 'getting all tasklists'
        id = BSON::ObjectId.from_string(params[:project_id])
        
        @project = Project.find(id)
        @agendas = @project.agendas
        @agendas.each do |agenda|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts agenda._id.to_s
       end
       ahash = { 'project' => @project, 'agendas' =>@agendas }
       puts ahash
       render json: ahash
     end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           id = BSON::ObjectId.from_string(params[:project_id])
           @project = Project.find(id)
           @agenda = @project.agendas.create(agenda_params)
           if @agenda.save
             isSuccess = true
              @added_agenda = Agenda.where(project_id: id).last
             # @added_task_list =@project.task_lists.last
             # ahash = { 'isSuccess' => true, 'task_list' =>@task_list }
             # puts ahash
             puts "create successfully"
             puts @added_agenda._id
   
             @array = Array.new
             @array.push(@added_task_list)
             
             render json:@added_agenda
           # Article对象也可以redirectto showpage
           else
             render plain: @added_agenda
           end
         end
         def update
           # @project = Project.find((params[:_id].__mongoize_object_id__))
           # @user = User.find(session[:current_user_id])
           id = BSON::ObjectId.from_string(params[:id])
           @agenda = Agenda.find(id)
       
           if @agenda.update(agenda_params)
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         def destroy 
          
           id = BSON::ObjectId.from_string(params[:id])
           @agenda = Agenda.find(id)
           if @agenda.destroy
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
        
         
         def agenda_params
           params.require(:agenda).permit(:_id,:project_id,:agenda_title, :agenda_isComplete,:agenda_start_time, :agenda_end_time, :complete_time,:agenda_repeat,:agenda_remind)
         end
   end
   