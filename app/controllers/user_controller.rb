class UserController < ApplicationController
  before_action :authorize_user

  def announcements
    @announcements = current_user.announcements.order(expired_at: :desc)
  end

  def offers
    @offers = case params[:status]
              when 'draft'
                current_user.offers.where(state: 'draft')
              when 'active'
                current_user.offers.joins(:announcement).where(state: 'published').where('announcements.expired_at > ?', Time.now)
              when 'expired'
                current_user.offers.joins(:announcement).where(state: 'published').where('announcements.expired_at < ?', Time.now)
              else
                redirect_to my_offers_path(status: :draft)
              end
  end

  def subscription
    @subscriber = current_user.subscriber
  end

  private

  def authorize_user
    authorize current_user
  end
end
