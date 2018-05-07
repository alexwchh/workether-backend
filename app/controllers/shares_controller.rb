class SharesController < ApplicationController
    def index
        puts 'getting all shares'
        id = BSON::ObjectId.from_string(params[:project_id])
        
        @project = Project.find(id)
        @shares = @project.shares
        @shares.each do |share|
         # project1=@user.projects.find()
         #    puts project1._id 
         puts share._id.to_s
       end
       ahash = { 'project' => @project, 'shares' =>@shares }
       puts ahash
       render json: ahash
     end
       def create
           puts 'session[user_id]:'
           puts session[:current_user_id]
           id = BSON::ObjectId.from_string(params[:project_id])
           @project = Project.find(id)
           @share = @project.shares.create(shares_params)
           if @project.save
             isSuccess = true
              @added_share = Share.where(project_id: id).last
             # @added_task_list =@project.task_lists.last
             # ahash = { 'isSuccess' => true, 'task_list' =>@task_list }
             # puts ahash
             puts "create successfully"
             puts @added_share._id
   
             @array = Array.new
             @array.push(@added_share)
             
             render json:@added_share
           # Article对象也可以redirectto showpage
           else
             render plain: @added_share
           end
         end
         def update
           # @project = Project.find((params[:_id].__mongoize_object_id__))
           # @user = User.find(session[:current_user_id])
           id = BSON::ObjectId.from_string(params[:id])
           @share = Share.find(id)
       
           if @share.update(shares_params)
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         def destroy 
          
           id = BSON::ObjectId.from_string(params[:id])
           @share = Share.find(id)
           if @share.destroy
               isSuccess=true
           else
               isSuccess=false
           end 
           render json:isSuccess
         end
         
         
         def shares_params
           params.require(:share).permit(:_id,:project_id,:share_title, :share_content, :share_creatTime, :last_modified_time)
         end
end
