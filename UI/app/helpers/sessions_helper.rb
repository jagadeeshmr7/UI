module SessionsHelper

   def sign_in(user)
         # Save cookie, only if user says "Remember me" on the login screen. 
         # else, save it only for this session.
   	   if (params[:session][:remember_me].nil?) #dont save the credentials...
            session[:remember_token] = user.remember_token            
   	   else
            cookies.permanent[:remember_token] = user.remember_token
   	   end
   	   self.current_user = user
   end

   def signed_in?
   	   !current_user.nil?
   end
   
   def signed_in_user
      unless signed_in?
         store_location
         redirect_to signin_url
      end
   end

   def sign_out
   	   self.current_user = nil
   	   cookies.delete(:remember_token)
   	   session.delete(:remember_token)
   end

   def current_user=(user)
   	   @current_user = user
   end

   def current_user
   	   # Get the user based on remember_token, if and only if current_user is undefined
       token = cookies[:remember_token] || session[:remember_token]
   	   @current_user ||= User.find_by_remember_token(token)
   end

   def current_user?(user)
   	   user == current_user
   end

   def redirect_back_or(default)
   	   redirect_to(session[:return_to] || default)
   	   session.delete(:return_to)
   end

   def store_location
   	   session[:return_to] = request.url
   end

   def admin_user
       signed_in_user
       redirect_to(signin_path) unless current_user.admin?
   end
end
