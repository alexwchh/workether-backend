class SubtasksController < ApplicationController
    def index
        puts 'getting all subtasks'
        id = BSON::ObjectId.from_string(params[:task_id])
        
        @task = Task.find(id)
        @tasks = @task.subtasks
        @tasks.each do |subtask|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts subtask._id.to_s
       end
       render json: @tasks
       end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           id = BSON::ObjectId.from_string(params[:task_id])
           @task = Task.find(id)
           @subtask = @task.subtasks.create(task_params)
           if @task.save
             isSuccess = true
              @added_task = Subtask.where(task_id: id).last
             # @added_task_list =@project.task_lists.last
             # ahash = { 'isSuccess' => true, 'task_list' =>@task_list }
             # puts ahash
             puts "create successfully"
             puts @added_task._id
   
             
             render json:@added_task
           # Article对象也可以redirectto showpage
           else
             render plain: @added_task
           end
         end
         def update
           # @project = Project.find((params[:_id].__mongoize_object_id__))
           # @user = User.find(session[:current_user_id])
           id = BSON::ObjectId.from_string(params[:id])
           @subtask = Subtask.find(id)
       
           if @subtask.update(task_params)
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         def destroy 
          
           id = BSON::ObjectId.from_string(params[:id])
           @task = Subtask.find(id)
           if @task.destroy
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         def order
           @tasks=Array.new(params[:_json])
           # puts @task_lists
           @tasks.each do |task|
             id = BSON::ObjectId.from_string(task[:_id][:$oid]) 
             @task = Subtask.find(id)
             @task.update_attribute(:task_order,task[:task_order])
           end
   
         end
         def complete_all
            @tasks=Array.new(params[:_json])
            # puts @task_lists
            @tasks.each do |task|
              id = BSON::ObjectId.from_string(task[:_id][:$oid]) 
              @task = Subtask.find(id)
              @task.update_attribute(:task_isComplete,task[:task_isComplete])
            end
        end
         
         def task_params
           params.require(:subtask).permit(:_id,:task_id,:task_title, :task_order, :task_remindDate, :task_isComplete,:task_creatTime,:task_isRemind,:task_isRepeat,:task_notes,:task_prl)
         end
end