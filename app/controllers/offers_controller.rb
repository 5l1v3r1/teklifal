class OffersController < ApplicationController
  before_action :set_announcement
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  def edit
    3.times { @offer.attachments.build }
  end

  def create
    @offer = @announcement.offers.build(offer_params)

    if @offer.save
      redirect_to @announcement, notice: 'Offer was successfully created.'
    else
      render 'announcements/show'
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_to [@announcement, @offer], notice: 'Offer was successfully updated.'
    else
      render 'announcements/show'
    end
  end

  def destroy
    @offer.destroy
    redirect_to @announcement, notice: 'Offer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:announcement_id, :desc, attachments_attributes: [:id, :file, :_destroy])
    end

    def set_announcement
      @announcement = Announcement.find(params[:announcement_id])
    end
end
