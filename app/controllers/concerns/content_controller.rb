class ContentController < ApplicationController

  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :authorize_content, only: [:edit, :update]
  before_action :authorize_content_resource, only: [:new, :create]

  def index
    @contents = content_resource.all
  end

  def new
    if  !user_signed_in? and
        session[:created_announcement] and
        ann = Announcement.unscoped.find(session[:created_announcement]) and
        ann.content and
        ann.content.class == content_resource
      @content = ann.content
      if params[:reset]
        ann.destroy
        session.delete(:created_announcement)
        @content = content_resource.new
        @ann = @content.build_announcement
        3.times { @ann.attachments.build }
      end
    else
      @content = content_resource.new
      @ann = @content.build_announcement user: current_user
      3.times { @ann.attachments.new }
    end
  end

  def create
    @content = content_resource.new
    # @content.build_announcement(user: current_user)

    @content.assign_attributes content_params
    @content.announcement.user = current_user if user_signed_in?
    # @content.announcement.supervisor = User.lazy
    # @content.announcement.content_type = content_resource

    if @content.save
      if user_signed_in?
        redirect_to @content.announcement
      else
        session[:created_announcement] = @content.announcement.id
        redirect_to new_user_registration_path(ann_created: :true)
      end
    else
      if @content.announcement.attachments.size < 3
        3.times { @content.announcement.attachments.build }
      end
      render action: :new
    end
  end

  def edit
    if @content.announcement.attachments.size == 0
      @content.announcement.attachments.new
    end
  end

  def update
    if @content.update(content_params)
      if user_signed_in?
        redirect_to @content.announcement, notice: 'Announcement was successfully updated.'
      else
        redirect_to new_user_registration_path(ann_created: :true)
      end
    else
      3.times { @content.announcement.attachments.new }
      render action: :edit
    end
  end

  private

  def set_content
    @content = content_resource.find(params[:id])  
  end

  def content_params
    params.require(content_resource.to_s.underscore.to_sym).
           permit(*policy(@content || content_resource).permitted_attributes)
  end

  def content_resource
    CarAnnouncement
  end

  def authorize_content
    authorize @content
  end

  def authorize_content_resource
    authorize content_resource
  end

end