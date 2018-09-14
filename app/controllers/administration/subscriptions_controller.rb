module Administration
  class SubscriptionsController < BaseController
    def index
      @subscriptions = Subscription.where(type: content_type).page(params[:page])
    end

    private

    def content_type

    end

  end
end