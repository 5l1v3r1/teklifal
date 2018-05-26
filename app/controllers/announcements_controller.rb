class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy, :expire]

  def index
    authorize Announcement
    @announcements = Announcement.all
  end


  def show
    authorize @announcement
  end

  def new
    authorize Announcement
    @announcement = Announcement.new
    3.times { @announcement.attachments.build }
  end

  def edit
    authorize @announcement
    3.times { @announcement.attachments.build }
  end

  def create
    authorize Announcement
    @announcement = Announcement.new(announcement_params).tap do |ann|
      ann.user = current_user
    end
    3.times { @announcement.attachments.build }

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render :show, status: :created, location: @announcement }
      else
        format.html { render :new }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @announcement
    3.times { @announcement.attachments.build }
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
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
      @announcement = Announcement.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit(:desc, :duration_day, attachments_attributes: [:id, :file, :_destroy])
    end
end
