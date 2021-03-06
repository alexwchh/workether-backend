class TagsController < ApplicationController
    def index
        puts 'getting all tags'
        id = BSON::ObjectId.from_string(params[:task_id])
        
        @task= Task.find(id)
        @tags = @task.tags
        @tags.each do |tag|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts tag._id.to_s
       end
       render json: @tags
       end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           id = BSON::ObjectId.from_string(params[:task_id])
           @task = Task.find(id)
           @tag = @task.tags.create(tag_params)
           if @task.save
             isSuccess = true
              @added_tag = Tag.where(task_id: id).last
             # @added_task_list =@project.task_lists.last
             # ahash = { 'isSuccess' => true, 'task_list' =>@task_list }
             # puts ahash
             puts "create successfully"
             puts @added_tag._id
    
             
             render json:@added_tag
           # Article对象也可以redirectto showpage
           else
             render plain: @added_tag
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
           @tag = Tag.find(id)
           if @tag.destroy
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         
         
         def tag_params
           params.require(:tag).permit(:_id,:task_id,:tag_title)
         end
end
