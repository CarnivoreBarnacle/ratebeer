class SessionsController < ApplicationController

  	def new

  	end
  	
  	def create
		user = User.find_by username: params[:username]
		
		if user and user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to user, notice: "Welcome back!"
		else
			redirect_to :back, notice: "Wrong username or password!"
		end
  	end
  	
  	def destroy
  		session[:user_id] = nil
  		
  		redirect_to root_path
  	end
end
