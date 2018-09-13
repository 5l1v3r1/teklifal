module Administration
  class OffersController < BaseController

    def index
      @offers = Offer.unscoped.all.includes(:subscriber, :announcement)
    end

    def show
      @offer = Offer.find params[:id]
    end

    def new
      @offer = Offer.new
    end

    def create
      @offer = Offer.new(offer_params)

      if @offer.save
        if params[:publish]
          @offer.publish!
          # TODO: UserMailer.with(offer: @offer).new_offer.deliver_later
          # TODO: Sms.send_sms to: @announcement.user.phone, message: "Yeni teklifiniz var."
        end

        redirect_to [:administration, @offer]
      else
        render :new
      end
    end

    def edit
      @offer = Offer.find params[:id]
    end

    def update
      @offer = Offer.find params[:id]

      if @offer.update(offer_params)
        if params[:publish] && @offer.draft?
          @offer.publish!
          # TODO: UserMailer.with(offer: @offer).new_offer.deliver_later
          # TODO: Sms.send_sms to: @announcement.user.phone, message: "Yeni teklifiniz var."
        end
        redirect_to [:administration, @offer]
      else
        render :edit
      end
    end

    private

    def offer_params
      params.require(:offer).permit( :subscriber_id, :announcement_id,
        :desc, attachments_attributes: [:id, :file, :_destroy]
      )
    end
  end
end