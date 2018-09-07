class RegistrationsController < Devise::RegistrationsController
  include AssociateAnnouncementToUser

  def create
    if @ann = added_announcement?
      instance_eval { def after_sign_up_path_for(resource)
          @ann
      end }
      params[:ann_created] = true
      params[:content_type] = @ann.content_type_name
    end

    super

    associate_orphan_announcement_to_user(@ann) if @ann
  end
  # def create
  #   build_resource(sign_up_params)

  #   resource.save
  #   yield resource if block_given?
  #   if resource.persisted?
  #     if resource.active_for_authentication?
  #       set_flash_message! :notice, :signed_up
  #       sign_up(resource_name, resource)
  #       associate_orphan_announcement_to_user(@ann) if @ann
  #       if @ann = added_announcement?
  #         respond_with resource, location: @ann
  #       else
  #         respond_with resource, location: after_sign_up_path_for(resource)
  #       end
  #     else
  #       set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
  #       expire_data_after_sign_in!
  #       respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #     end
  #   else
  #     clean_up_passwords resource
  #     set_minimum_password_length
  #     params[:ann_created] = true
  #     respond_with resource
  #   end
  # end

end