class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:username])
        
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            if user.role == "admin"
                redirect_to products_path
            else
                redirect_to sell_path
            end
        else
            flash[:alert] = "Invalid username or password"
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil 
        redirect_to root_path, notice: "Logged out"
    end
end
