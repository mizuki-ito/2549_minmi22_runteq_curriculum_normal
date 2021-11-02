class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(admin_user_params)
      redirect_to admin_user_path(@user), success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit 
    end  
  end

  def destroy
    if @user.destroy!
      redirect_to admin_user_path, success: t('defaults.message.deleted', item: User.model_name.human)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :avatar_cache :role)
  end


end
