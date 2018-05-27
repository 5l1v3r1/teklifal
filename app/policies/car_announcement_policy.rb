class CarAnnouncementPolicy < ApplicationPolicy

  def new?
    create?
  end

  def create?
    signed_user
  end

  def edit?
    update?
  end

  def update?
    signed_user?(content.announcement) or
    signed_user.manager?
  end

  def destroy?
    signed_user?(content.announcement) or
    signed_user.manager?
  end

  def permitted_attributes
    # Content attributes
    attrs = [:make]
    
    # Add attributes for policy
    announcement_attrs = { announcement_attributes: [:desc, attachments_attributes: [:id, :file, :_destroy]] }
    if record.new_record?
      announcement_attrs[:announcement_attributes] << :duration_day
    end

    # Add nested attributes to content attributes
    attrs << node_attrs

    # Return attributes
    attrs
  end

end