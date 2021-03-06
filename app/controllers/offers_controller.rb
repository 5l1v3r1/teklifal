require 'sms'

class OffersController < ApplicationController
  before_action :set_announcement, except: :index
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers/1
  # GET /offers/1.json
  def show
    authorize @offer
  end

  def new
    @offer = @announcement.offers.new
    authorize @offer
  end

  def edit
    authorize @offer
    3.times { @offer.attachments.build }
  end

  def create
    @offer = @announcement.offers.build(offer_params).tap do |offer|
      offer.subscriber = current_user.subscriber
    end
    authorize @offer

    if @offer.save
      if params[:publish]
        @offer.publish!
        UserMailer.with(offer_id: @offer.id).new_offer.deliver_later
        Sms.send_sms to: @announcement.user.phone, message: "Yeni teklifiniz var."
      end

      redirect_to @announcement, notice: 'Offer was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @offer

    if @offer.update(offer_params)
      if params[:publish] && @offer.draft?
        @offer.publish!
        UserMailer.with(offer_id: @offer.id).new_offer.deliver_later
        Sms.send_sms to: @announcement.user.phone, message: "Yeni teklifiniz var."
      end

      redirect_to @announcement, notice: 'Offer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @offer
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
      @announcement = Announcement.unscoped.find(params[:announcement_id])
    end
end
