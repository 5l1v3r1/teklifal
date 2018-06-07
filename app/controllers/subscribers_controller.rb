class SubscribersController < ApplicationController
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
    @subscriber = Subscriber.new
  end

  def edit
    authorize @subscriber
  end

  def create
    authorize Subscriber
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.owner = current_user

    if @subscriber.save
      redirect_to @subscriber, notice: 'Subscriber was successfully created.'
    else
      render :new
    end
  end

  def update
    if @subscriber.update(subscriber_params)
      redirect_to @subscriber, notice: 'Subscriber was successfully updated.'
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
      @subscriber = Subscriber.find(params[:id])
    end

    def subscriber_params
      params.require(:subscriber).permit(:title, :type, :owner_id)
    end
end
