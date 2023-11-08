class Authentication::UsersController < ApplicationController
    skip_before_action :protect_pages
    
    def show
     @user = current_user
    end

    def new
        @user= User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            session[:user_id] = @user.id
            redirect_to new_dog_path 
        else
            render :new, status: :unprocessable_entity
        end
    end
     
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])

        if @user.update(user_params)
            flash[:notice] = 'Sus datos se han modificado correctamente.'
          redirect_to user_path(@user)
        else
           render :edit, status: :unprocessable_entity
        end 
    end

    def edit_password
        @user = current_user
      end
    
      def update_password
        @user = current_user
        if @user&.authenticate(params[:user][:current_password])
          if params[:user][:password] == params[:user][:password_confirmation]
            if @user.update(password: params[:user][:password])
              redirect_to user_path(@user), notice: 'Contraseña actualizada correctamente.'
            else
              flash[:alert] = 'Hubo un problema al actualizar la contraseña.'
              render 'edit_password'
            end
          else
            flash[:alert] = 'Las contraseñas no coinciden.'
            render 'edit_password'
          end
        else
          flash[:alert] = 'Contraseña actual incorrecta.'
          render 'edit_password'
        end
      end
    
 private
    def user_params
        params.require(:user).permit(:email, :dni, :nombre, :apellido, :rol, :password)
    end
end
