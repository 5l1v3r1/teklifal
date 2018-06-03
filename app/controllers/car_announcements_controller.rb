class CarAnnouncementsController < ApplicationController
  # ca = car_announcement
  skip_after_action :verify_authorized
  before_action :set_ca, only: [:show, :edit, :update, :destroy]

  def index
    @cas = CarAnnouncement.all
  end

  def new
    @ca = CarAnnouncement.new
    @ann = @ca.build_announcement user: current_user
    3.times { @ann.attachments.new }
  end

  def edit
  end

  def create
    @ca = CarAnnouncement.new(ca_params)
    @ca.assign_attributes ca_params
    @ca.announcement.user = current_user
    # @ann = @ca.build_announcement user: current_user

    if @ca.save
      redirect_to @ca.announcement, notice: 'Car announcement was successfully created.'
    else
      render :new
    end
  end

  def update
    if @ca.update(ca_params)
      redirect_to @ca.announcement, notice: 'Car announcement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @car_announcement.destroy
    redirect_to car_announcements_url, notice: 'Car announcement was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ca
      @ca = CarAnnouncement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ca_params
      params.require(:car_announcement).permit(
        :make,
        announcement_attributes: [
          :id,
          :title,
          :desc,
          :duration_day,
          attachments_attributes: [
            :id,
            :file,
            :_destroy
          ]
        ]
      )
    end
end
