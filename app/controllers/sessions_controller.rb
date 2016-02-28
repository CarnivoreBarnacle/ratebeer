class SessionsController < ApplicationController

  	def new

  	end
  	
  	def create
		user = User.find_by username: params[:username]
		
		if user and user.authenticate(params[:password])
			if user.banned
				redirect_to :back, notice: "#{user.username} has been banned, please contanct site administration"
			else
				session[:user_id] = user.id
				redirect_to user, notice: "Welcome back!"
			end
		else
			redirect_to :back, notice: "Wrong username or password!"
		end
  	end
  	
  	def destroy
  		session[:user_id] = nil
  		
  		redirect_to root_path
  	end
end
