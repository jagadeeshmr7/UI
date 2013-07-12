class SessionsController < ApplicationController

   def new
   	   flash.now[:info] = "Please login with your Username and Password."
   end

   def create
   	  user = User.find_by_name(params[:session][:name].downcase)
   	  if user && user.authenticate(params[:session][:password])
   	  	 sign_in user
   	  	 redirect_back_or '/dash_inventory'
   	  else
   	  	 flash.now[:error] = 'Invalid name/password combination'
   	  	 render 'new'
   	  end
   end

   def destroy
   	  sign_out
   	  redirect_to signin_path
   end
end