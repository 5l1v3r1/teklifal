class SubscriberController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  def index
    authorize Subscriber
    @subscribers = Subscriber.all
  end

  def show
    authorize @subscriber
  end

  def new
    authorize Subscriber
    if @subscriber = current_user.subscriber
      redirect_to edit_subscriber_path, alert: "You have already a subscriber account. You can now edit it."
    else
      @subscriber = Subscriber.new
    end
  end

  def edit
    authorize @subscriber
  end

  def create
    authorize Subscriber
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.owner = current_user

    if @subscriber.save
      redirect_to edit_subscriber_path, notice: 'Subscriber was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @subscriber
    if @subscriber.update(subscriber_params)
      redirect_to edit_subscriber_path, notice: 'Subscriber was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subscriber.destroy
    redirect_to subscribers_url, notice: 'Subscriber was successfully destroyed.'
  end

  private
    def set_subscriber
      @subscriber = current_user.subscriber
    end

    def subscriber_params
      params.require(:subscriber).permit(:title, :subscriber_type)
    end
end
