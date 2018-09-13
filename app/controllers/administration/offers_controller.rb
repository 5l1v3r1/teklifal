module Administration
  class OffersController < BaseController
    def index
      @offers = Offer.unscoped.all.includes(:subscriber, :announcement)
    end
  end
end