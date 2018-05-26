module Administration
  class UsersController < BaseController
    def index
      @users = User.unscoped.all
    end
  end
end