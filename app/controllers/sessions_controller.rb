class SessionsController < Devise::SessionsController
  include AssociateAnnouncementToUser

  def create
    if @ann = added_announcement?
      instance_eval { def after_sign_in_path_for(resource)
          @ann
      end }
    else
      instance_eval { def after_sign_in_path_for(resource)
        new_user_session_path(ann_created: true)
      end }
    end

    super

    associate_orphan_announcement_to_user(@ann) if @ann
  end
end