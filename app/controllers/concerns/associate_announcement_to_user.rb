module AssociateAnnouncementToUser
  extend ActiveSupport::Concern

  included do
    helper_method :added_announcement?
  end

  private

  def associate_orphan_announcement_to_user announcement
    if user_signed_in?
      announcement.update user: current_user
      session.delete(:created_announcement)
    end
  end

  def added_announcement?
    params[:user][:signed_in_from_new_announcement] and
    session[:created_announcement] and
    Announcement.unscoped.find(session[:created_announcement])
  end
end