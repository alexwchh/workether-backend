class TaskListsController < ApplicationController
    def index
     puts 'getting all tasklists'
     id = BSON::ObjectId.from_string(params[:project_id])
     
     @project = Project.find(id)
     @tasklists = @project.task_lists
     @tasklists.each do |task_list|
      # project1=@user.projects.find()
      #    puts project1._id 
      puts task_list._id.to_s
    end
    render json: @tasklists
    end
    def create
        puts 'session[user_id]:'
        puts session[:current_user_id]
        id = BSON::ObjectId.from_string(params[:project_id])
        @project = Project.find(id)
        @tasklist = @project.task_lists.create(task_lists_params)
        if @project.save
          isSuccess = true
           @added_task_list = TaskList.where(project_id: id).last
          # @added_task_list =@project.task_lists.last
          # ahash = { 'isSuccess' => true, 'task_list' =>@task_list }
          # puts ahash
          puts "create successfully"
          puts @added_task_list._id

          @array = Array.new
          @array.push(@added_task_list)
          
          render json:@added_task_list
        # Article对象也可以redirectto showpage
        else
          render plain: @tasklist
        end
      end
      def update
        # @project = Project.find((params[:_id].__mongoize_object_id__))
        # @user = User.find(session[:current_user_id])
        id = BSON::ObjectId.from_string(params[:id])
        @tasklist = TaskList.find(id)
    
        if @tasklist.update(task_lists_params)
            isSuccess=true
        else
            isSuccess=false
        end 
        render json:isSuccess
      end
      def destroy 
       
        id = BSON::ObjectId.from_string(params[:id])
        @tasklist = TaskList.find(id)
        if @tasklist.destroy
            isSuccess=true
        else
            isSuccess=false
        end 
        render json:isSuccess
      end
      def order
        @tasklists=Array.new(params[:_json])
        # puts @task_lists
        @tasklists.each do |task_list|
          id = BSON::ObjectId.from_string(task_list[:_id][:$oid]) 
          @tasklist = TaskList.find(id)
          @tasklist.update_attribute(:task_list_order,task_list[:task_list_order])
        end

      end
      
      def task_lists_params
        params.require(:task_list).permit(:_id,:project_id,:task_list_title, :task_list_order, :task_list_creatTime, :task_list_isActive)
      end
end
