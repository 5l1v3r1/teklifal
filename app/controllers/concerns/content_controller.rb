class ContentController < ApplicationController

  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :authorize_content, only: [:edit, :update]
  before_action :authorize_content_resource, only: [:new, :create]

  def index
    @contents = content_resource.all
  end

  def new
    if existing_announcement_for_current_user?
      @content = @ann.content
      if params[:reset]
        @ann.destroy
        session.delete(:created_announcement)
        @content = content_resource.new
        @ann = @content.build_announcement
      end
    else
      @content = content_resource.new
      if params.has_key?(content_param_name)
        @content.assign_attributes content_params
      end
      @content.build_announcement unless @content.announcement
      @ann = @content.announcement
      @ann.user = current_user
    end

    3.times { @content.announcement.attachments.new }
  end

  def create
    @content = content_resource.new
    @content.assign_attributes content_params
    @content.announcement.user = current_user if user_signed_in?

    if @content.save
      if user_signed_in?
        redirect_to @content.announcement
      else
        session[:created_announcement] = @content.announcement.id
        redirect_to new_user_registration_path(ann_created: :true, content_type: content_type)
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
        redirect_to new_user_registration_path(ann_created: :true, content_type: content_type)
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
    params.require(content_param_name).
           permit(*policy(@content || content_resource).permitted_attributes)
  end

  def content_param_name
    content_resource.to_s.underscore.to_sym
  end

  def content_resource
    CarAnnouncement
  end

  helper_method :content_type
  def content_type
    content_resource.to_s.underscore.tap do |str|
      str.slice!("_announcement")
      str
    end
  end

  def authorize_content
    authorize @content
  end

  def authorize_content_resource
    authorize content_resource
  end

  def is_user_coming_from_homepage_form?
    params.has_key? content_param_name
  end

  def has_a_anonymous_announcement?
    anonymous_user? and session[:created_announcement]
  end

  helper_method :created_announcement, :ask_to_continue?
  def created_announcement
    Announcement.find_by(id: session[:created_announcement])
  end

  def ask_to_continue?
    session[:created_announcement] and
    anonymous_user? and
    !params[:continuing_edit] and
    created_announcement.content_type == content_resource.to_s
  end

  def existing_announcement_for_current_user?
    !user_signed_in? and
    session[:created_announcement] and
    @ann = Announcement.find_by(id: session[:created_announcement]) and
    @ann.content and
    @ann.content_type == content_resource.to_s
  end

end