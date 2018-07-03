class ContentPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    record.announcement.owner?(signed_user) or
    signed_user.manager?
  end

  def destroy?
    update?
  end

  def permitted_attributes
    content_attributes << announcement_attrs
    content_attributes
  end

  private

  def announcement_attrs
    announcement_attrs = {
      announcement_attributes: [
        :id,
        :title,
        :desc,
        attachments_attributes: [:id, :file, :_destroy]
      ]
    }

    if record.new_record?
      announcement_attrs[:announcement_attributes] << :duration_day
    end

    announcement_attrs
  end

  # Must be blank array for root content policy
  def content_attributes
    @content_attributes ||= []
  end

end