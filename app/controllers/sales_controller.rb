class SalesController < ApplicationController
    def new
        if session[:user_id]
            @user = User.find(session[:user_id])
        end    
    end
end