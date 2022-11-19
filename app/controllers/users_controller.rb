class UsersController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            if @user.role == "admin"
                redirect_to products_path, notice: "Sucessfully created admin user"
            else
                redirect_to sell_path, notice: "Sucessfully created cashier user"
            end
        else
            flash[:alert] = "Something went wrong"
            render :new
        end

        #  render plain: "Thanks"
    end
    def user_params
        params.require(:user).permit(:username, :role, :password, :password_confirmation)
    end
end
