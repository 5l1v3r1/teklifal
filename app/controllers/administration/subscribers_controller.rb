module Administration
  class SubscribersController < BaseController
    respond_to :js, only: :ann_subscribers

    def index
      Subscriber.all.tap do |s|
        s = s.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
        s = s.page(params[:page])
        @subscribers = s
      end
    end

    def ann_subscribers
      ann = Announcement.find params[:announcement_id]
      @subscribers = ann.subscribers

      respond_with @subscribers
    end

    def destroy
      @subscriber = Subscriber.find params[:id]
      if @subscriber.destroy
        redirect_to administration_subscribers_path, notice: "Silindi"
      end
    end

  end
end