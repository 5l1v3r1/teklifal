module Administration
  class AnnouncementsController < BaseController
    def index
      @announcements = Announcement.unscoped.all.includes(:user)
    end
  end
end