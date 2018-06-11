class CarAnnouncementsController < ApplicationController
  # ca = car_announcement
  before_action :set_ca, only: [:show, :edit, :update, :destroy]

  def index
    authorize CarAnnouncement
    @cas = CarAnnouncement.all
  end

  def new
    authorize CarAnnouncement
    @ca = CarAnnouncement.new(params[:car_announcement] && ca_params)
    @ann = @ca.announcement || @ca.build_announcement
    @ann.user = current_user

    3.times { @ann.attachments.new }
  end

  def edit
    authorize @ca
  end

  def create
    authorize CarAnnouncement
    @ca = CarAnnouncement.new(ca_params)
    @ca.assign_attributes ca_params
    @ca.announcement.user = current_user
    # @ca.announcement.supervisor = User.lazy
    # @ann = @ca.build_announcement user: current_user

    if @ca.save
      redirect_to @ca.announcement, notice: 'Car announcement was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @ca

    if @ca.update(ca_params)
      redirect_to @ca.announcement, notice: 'Car announcement was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @ca
    @ca.destroy
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
