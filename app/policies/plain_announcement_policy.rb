class PlainAnnouncementPolicy < ContentPolicy

  private

  def announcement_attrs
    announcement_attrs = {
      announcement: [
        :id,
        :title,
        :desc,
        attachments_attributes: [:id, :file, :_destroy]
      ]
    }

    if record.is_a?(PlainAnnouncement) and record.new_record?
      announcement_attrs[:announcement] << :duration_day
    end

    announcement_attrs
  end

  def content_attributes
    @content_attributes ||= []
  end 

end