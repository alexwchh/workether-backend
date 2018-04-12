class UsersController < ApplicationController
  def create
    @user = User.new(users_params)
    if @user.save
      session[:current_user_id]=@user._id
      @@logged_user = @user
      isSuccess = true
      ahash = { 'isSuccess' => true, 'user' => @user }
      puts ahash
      render json: ahash
    # Article对象也可以redirectto showpage
    else
      render plain: @user
    end
  end

  private

  def users_params
    params.require(:user).permit(:_id, :psw)
  end
end
