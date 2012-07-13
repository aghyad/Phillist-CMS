module Refinery
  class UsersController < Devise::RegistrationsController

    # Protect these actions behind an admin login
#    before_filter :redirect?, :only => [:new, :create]

    helper Refinery::Core::Engine.helpers
    layout 'refinery/layouts/login'

    ### ==> /refinery/users/register
    def new 
      if !Website::Application.config.enable_login_register_functionality
        Rails.logger.debug "\n\n\n\n\nRefinery::Users.new\n\n\n\n\n"        
        ### if login/registration setting is disable --> you can not register a user unless you're a logged-in superuser
        if current_refinery_user.nil?
          redirect_to "/refinery/login" and return
        elsif !current_refinery_user.nil? and current_refinery_user.has_role?(:superuser)
          redirect_to "/refinery/users/new" and return
        else
          @user = User.new
        end
      else
        #@user = User.new
        if current_refinery_user.nil?
          redirect_to "/refinery/login" and return
        elsif !current_refinery_user.nil?
          if current_refinery_user.has_role?(:superuser)
            redirect_to "/refinery/users/new" and return
            @user = User.new            
          else
            redirect_to "/" and return
          end
        end
      end
    end

    # This method should only be used to create the first Refinery user.
    def create
      @user = User.new(params[:user])
      
      if @user.create_first
        flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe

        sign_in(@user)
        redirect_back_or_default(refinery.admin_root_path)
      else
        render :new
      end
    end

    protected

    def redirect?
      if refinery_user?
        redirect_to refinery.admin_users_path
      elsif refinery_users_exist?
        redirect_to refinery.new_refinery_user_session_path
      end
    end
    
    def refinery_users_exist?
      Refinery::Role[:refinery].users.any?
    end

  end
end
