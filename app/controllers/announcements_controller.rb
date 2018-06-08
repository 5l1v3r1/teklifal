class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy, :expire]

  def show
    authorize @announcement
  end

  def new
    authorize Announcement
  end

  def plain
    authorize Announcement
    @announcement = Announcement.new
    3.times { @announcement.attachments.build }
  end

  def edit
    if @announcement.content
      redirect_to send(:"edit_#{@announcement.content_type_name}_path", @announcement.content)
    end
    authorize @announcement
    3.times { @announcement.attachments.build }
  end

  def create
    authorize Announcement
    @announcement = Announcement.new(announcement_params).tap do |ann|
      ann.user = current_user
    end

    if @announcement.save
      redirect_to @announcement, notice: 'Announcement was successfully created.'
    else
      if @announcement.attachments.size < 3
        3.times { @announcement.attachments.build }
      end
      render :new
    end
  end

  def update
    authorize @announcement
    if @announcement.update(announcement_params)
      redirect_to @announcement, notice: 'Announcement was successfully updated.'
    else
      3.times { @announcement.attachments.build }
      render :edit
    end
  end


  def destroy
    authorize @announcement
    @announcement.destroy
    redirect_to announcements_url, notice: 'Announcement was successfully destroyed.'
  end

  def expire
    authorize @announcement
    @announcement.expire!
    redirect_to announcements_url, notice: 'Announcement was successfully expired.'
  end

  private
    def set_announcement
      @announcement = Announcement.unscoped.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit(:title, :desc, :supervisor_id, :duration_day, attachments_attributes: [:id, :file, :_destroy])
    end
end
