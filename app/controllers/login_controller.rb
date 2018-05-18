class LoginController < ApplicationController
    def login
        if @user = User.find_by(email: params[:email])    
            if @user.psw == params[:psw]
                @@logged_user=@user
                isSuccess=true
                # session set current user
                
                session[:current_user_id]=@user._id
                puts "session[userid]:"
                puts session[:current_user_id]
                ahash={"isSuccess" =>true,"user"=>@user}
                puts ahash
                render json:ahash
            else
                isSuccess=false
                ahash={"isSuccess" =>false,"user"=>@user}
                puts ahash
                render json:ahash
            end
        end
    end
    def destroy
        # session[:current_user_id] = nil
        
    end
    private 
    def users_params
        params.require(:user).permit(:_id,:psw,:email,:name)
    end
end
