module Administration
  class SubscriptionsController < BaseController
    before_action :set_subscription, only: [:edit, :show, :update, :destroy]
    before_action :set_user, only: [:create, :new]

    def show
    end

    def new
      @subscription = subscription_class.new subscriber: @user.subscriber
    end

    def create
      @subscription = subscription_class.new.tap do |subscription|
        subscription.subscriber = @user.subscriber
        subscription.assign_attributes subscription_params
      end 

      if @subscription.save
        redirect_to administration_user_path(@user),
          notice: "Succesfuly saved subscription."
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @subscription.update subscription_params
        redirect_to administration_user_subscriptions_path,
          notice: "Succesfuly updated subscription."
      else
        render :edit
      end
    end

    private

    def subscription_params
      params.require(:subscription).permit(
        *policy(subscription_class).permitted_attributes
      )
    end

    def set_subscription
      @subscription = Subscription.find params[:id]
    end

    def set_user
      @user = User.find params[:user_id]
    end

    def subscription_class
      (params[:type] or
      params[:subscription][:type]).safe_constantize
    end

  end
end