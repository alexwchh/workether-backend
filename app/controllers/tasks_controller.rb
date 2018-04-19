class TasksController < ApplicationController

def index
    puts 'getting all tasks'
    id = BSON::ObjectId.from_string(params[:task_list_id])
    
    @task_list = TaskList.find(id)
    @tasks = @task_list.tasks
    @tasks.each do |task|
     # project1=@user.projects.find()
     #    puts project1._id 
     puts task._id.to_s
   end
   render json: @tasks
   end
   def create
       puts 'session[user_id]:'
       puts session[:current_user_id]
       id = BSON::ObjectId.from_string(params[:task_list_id])
       @task_list = TaskList.find(id)
       @task = @task_list.tasks.create(task_params)
       if @task_list.save
         isSuccess = true
          @added_task = Task.where(task_list_id: id).last
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
       @task = Task.find(id)
   
       if @task.update(task_params)
           isSuccess=true
       else
           isSuccess=false
       end 
       render json:isSuccess
     end
     def destroy 
      
       id = BSON::ObjectId.from_string(params[:id])
       @task = Task.find(id)
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
         @task = Task.find(id)
         @task.update_attribute(:task_order,task[:task_order])
       end

     end
     def complete_all
        @tasks=Array.new(params[:_json])
        # puts @task_lists
        @tasks.each do |task|
          id = BSON::ObjectId.from_string(task[:_id][:$oid]) 
          @task = Task.find(id)
          @task.update_attribute(:task_isComplete,task[:task_isComplete])
        end
    end
     
     def task_params
       params.require(:task).permit(:_id,:task_list_id,:task_title, :task_order, :task_remindDate, :task_isComplete,:task_creatTime,:task_isRemind,:task_isRepeat,:task_notes,:task_prl)
     end
end