class UsersController < ApplicationController
  def index
  @users = User.all
  puts @users
  render json: @users
  end

  def create
    @user = User.new(users_params)
    if @user.save
      @added_User = User.all.last
      puts @added_User._id.to_s
      session[:current_user_id]=@added_User._id
      @@logged_user = @added_User
      isSuccess = true
      ahash = { 'isSuccess' => true, 'user' => @added_User }
      puts ahash
      render json: ahash
    # Article对象也可以redirectto showpage
    else
      render plain: @user
    end
  end

  def show
    id = BSON::ObjectId.from_string(params[:id])
    @user = User.find(id);
    render json: @user
  end

  

  def users_params
    params.require(:user).permit(:_id, :psw,:name,:email)
  end
end
