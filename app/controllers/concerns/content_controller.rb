class ContentController < ApplicationController

  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :authorize_content, only: [:edit, :update]
  before_action :authorize_content_resource, only: [:new, :create]

  def index
    @contents = content_resource.all
  end

  def new
    @content = content_resource.new
    @ann = @content.build_announcement user: current_user
    3.times { @ann.attachments.new }
  end

  def create
    @content = content_resource.new
    # @content.build_announcement(user: current_user)

    @content.assign_attributes content_params
    @content.announcement.user = current_user
    # @content.announcement.supervisor = User.lazy
    # @content.announcement.content_type = content_resource

    if @content.save
      redirect_to @content.announcement
    else
      3.times { @content.announcement.attachments.new }
      render action: :new
    end
  end

  def edit
  end

  def update
    if @content.update(content_params)
      redirect_to @content.announcement
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