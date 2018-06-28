class CarAnnouncementPolicy < ContentPolicy

  private

  def content_attributes
    @content_attributes ||= [:make]
  end
end