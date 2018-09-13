module Administration
  class SubscribersController < BaseController
    respond_to :js, only: :index

    def index
      ann = Announcement.find params[:announcement_id]
      @subscribers = ann.subscribers

      respond_with @subscribers
    end

  end
end