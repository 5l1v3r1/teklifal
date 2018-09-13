require './app/services/administration/unowned_user'

module Administration
  class UsersController < BaseController
    def index
      @users = if params[:q].present?
        User.unscoped.all.order(id: :desc).search(params[:q]).page(params[:page])
      else
        User.unscoped.all.order(id: :desc).page(params[:page])
      end
    end

    def show
      @user = User.find params[:id]
    end

    def new
      @user = UnownedUser.new
    end

    def create
      @user = UnownedUser.new(user_params)

      if @user.save
        redirect_to [:administration, User.find(@user.id)]
      else
        render :new 
      end
    end

    def edit
      @user = UnownedUser.find params[:id]
    end

    def update
      @user = UnownedUser.find params[:id]

      if @user.update(user_params)
        redirect_to [:administration, User.find(@user.id)]
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit( :first_name,
        :last_name, :email, :phone, subscriber_attributes: [
          :id, :title, :subscriber_type]
      )
    end
  end
end
