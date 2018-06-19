class SessionsController < Devise::SessionsController
  include AssociateAnnouncementToUser

  def create
    if @ann = added_announcement?
      instance_eval { def after_sign_in_path_for(resource)
          @ann
      end }
    end

    super

    if @ann
      set_flash_message!(:notice, :created_announcement_and_signed_in)
      associate_orphan_announcement_to_user(@ann)
    end
  end
end