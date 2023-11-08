class PasswordsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.authenticate(params[:user][:current_password])
      if @user.update(user_params)
        # Contraseña actualizada con éxito
        redirect_to user_path(@user), notice: 'Contraseña actualizada con éxito.'
      else
      end
    else
      # Contraseña actual incorrecta
      @user.errors.add(:current_password, 'Contraseña actual incorrecta')
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :current_password)
  end
end