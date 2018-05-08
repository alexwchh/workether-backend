class ShareCommentsController < ApplicationController
    def index
        puts 'getting all tags'
        id = BSON::ObjectId.from_string(params[:share_id])
        
        @share= Share.find(id)
        @share_comments = @share.share_comments
        @share_comments.each do |share|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts share._id.to_s
       end
       render json: @share_comments
       end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           @user = User.find(session[:current_user_id])
           puts @user.name
           id = BSON::ObjectId.from_string(params[:share_id])
           @share = Share.find(id)
           @share_comment = @share.share_comments.create(share_comment_params)
           
           if @share.save
             isSuccess = true
              @added_comment = ShareComment.where(share_id: id).last
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
           @share_comment = ShareComment.find(id)
           if @share_comment.destroy
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         
         
         def share_comment_params
           params.require(:share_comment).permit(:_id,:share_id,:commenter_id,:comment_content,:comment_time)
         end
end


