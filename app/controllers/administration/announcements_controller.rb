module Administration
  class AnnouncementsController < BaseController
    before_action :set_announcement, only: [:show, :edit, :update, :email]

    def index
      @announcements = Announcement.unscoped.all.includes(:user)
    end

    def new
      @announcemnt = Announcement.new
    end

    def create
      @announcement = Announcement.new announcement_params

      if @announcement.save
        redirect_to [:administration, @announcement], notice: "Success!"
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      if @announcement.update announcement_params
        redirect_to [:administration, @announcement], notice: "Success!"
      else
        render :edit
      end
    end

    private

    def set_announcement
      @announcement = Announcement.unscoped.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit(:title, :desc, :supervisor_id, :duration_day, attachments_attributes: [:id, :file, :_destroy])
    end
  end
end