class TaskCommentsController < ApplicationController
    def index
        puts 'getting all tags'
        id = BSON::ObjectId.from_string(params[:task_id])
        
        @task= Task.find(id)
        @task_comments = @task.task_comments
        @task_comments.each do |tag|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts tag._id.to_s
       end
       render json: @task_comments
       end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           @user = User.find(session[:current_user_id])
           puts @user.name
           id = BSON::ObjectId.from_string(params[:task_id])
           @task = Task.find(id)
           @task_comment = @task.task_comments.create(task_comment_params)
           
           if @task.save
             isSuccess = true
              @added_comment = TaskComment.where(task_id: id).last
              @added_comment.commenter = @user.name
              @added_comment.save
             # @added_task_list =@project.task_lists.last
             # ahash = { 'isSuccess' => true, 'task_list' =>@task_list }
             # puts ahash
             puts "create successfully"
           
    
             
             render json:@added_comment
           # Article对象也可以redirectto showpage
           else
             render plain: @added_comment
           end
         end
        #  def update
        #    # @project = Project.find((params[:_id].__mongoize_object_id__))
        #    # @user = User.find(session[:current_user_id])
        #    id = BSON::ObjectId.from_string(params[:id])
        #    @task = Task.find(id)
       
        #    if @task.update(task_params)
        #        isSuccess=true
        #    else
        #        isSuccess=false
        #    end 
        #    render json:isSuccess
        #  end
         def destroy 
          
           id = BSON::ObjectId.from_string(params[:id])
           @task_comment = TaskComment.find(id)
           if @task_comment.destroy
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         
         
         def task_comment_params
           params.require(:task_comment).permit(:_id,:task_id,:commenter_id,:comment_content,:comment_time)
         end
end

