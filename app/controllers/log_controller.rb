class LogController < ApplicationController
    def index
        puts 'getting all logs'
        #  id = BSON::ObjectId.from_string(params[:source_id])
        
        @logs = Log.where(user_id: session[:current_user_id]).all
        
        @logs.each do |log|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts log._id.to_s
       end
       render json: @logs
       end
       def show
        puts 'getting all logs'
         id = BSON::ObjectId.from_string(params[:_id])
        
        @logs = Log.where(source_id: id).all
        
        @logs.each do |log|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts log._id.to_s
       end
       render json: @logs   
    end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           id = BSON::ObjectId.from_string(params[:source_id])
           @task_list = TaskList.find(id)
           @task = @task_list.tasks.create(log_params)
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
         def log_params
            params.require(:log).permit(:_id,:user_id,:source_id, :operation, :operation_target,:create_time)
          end
end
