class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  respond_to :js, only: :index

  def my
    authorize Subscription
    @subscriptions = current_user.subscriber.subscriptions
  end

  def index
    authorize Subscription
    @subscriptions = subscription_source.search(params)
    respond_with @subscriptions
  end

  def show
    authorize @subscription
  end

  def new
    authorize subscription_source
    @subscription = subscription_source.new
  end

  def edit
    authorize @subscription
  end

  def create
    authorize subscription_source
    @subscription = subscription_source.new(subscription_params)
    @subscription.subscriber = current_user.subscriber

    if @subscription.save
      redirect_to subscription_path(@subscription.id), notice: 'Subscription was successfully created.'
    else
      render :new
    end
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: 'Subscription was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subscription.destroy
    redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.'
  end

  private
    def subscription_source
      params[:type].try(:classify).try(:safe_constantize) or
      params.fetch(:subscription, {}).fetch(:type, nil).try(:safe_constantize) or
      Subscription
    end

    def set_subscription
      @subscription = subscription_source.find(params[:id])
    end

    def subscription_params
      params.require(:subscription).permit(*policy(@subscription || subscription_source).permitted_attributes)
    end
end
