module Administration
  class OffersController < BaseController
    def index
      @offers = Offer.unscoped.all.includes(:user, :announcement)
    end
  end
end