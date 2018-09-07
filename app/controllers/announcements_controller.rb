class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy, :expire]

  def index
    authorize Announcement
    @announcements = Announcement.unscoped.all
  end

  def show
    authorize @announcement
  end

  def new
    authorize Announcement
  end

  def plain
    authorize Announcement
    if !user_signed_in? and session[:created_announcement]
      @announcement = Announcement.unscoped.find(session[:created_announcement])
      if params[:reset]
        @announcement.destroy
        session.delete(:created_announcement)
        @announcement = Announcement.new
        3.times { @announcement.attachments.build } 
      end
    else
      @announcement = Announcement.new
      3.times { @announcement.attachments.build }
    end
  end

  def edit
    if @announcement.content
      redirect_to send(:"edit_#{@announcement.content_type_name}_announcement_path", @announcement.content)
    end
    authorize @announcement
    3.times { @announcement.attachments.build }
  end

  def create
    authorize Announcement

    @announcement = Announcement.new(announcement_params).tap do |ann|
      ann.user = current_user if user_signed_in?
    end

    if @announcement.save
      if user_signed_in?
        redirect_to @announcement, notice: 'Announcement was successfully created.'
      else
        session[:created_announcement] = @announcement.id
        redirect_to new_user_registration_path(ann_created: :true)
      end
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
      if user_signed_in?
        redirect_to @announcement, notice: 'Announcement was successfully updated.'
      else
        redirect_to new_user_registration_path(ann_created: :true)
      end
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
