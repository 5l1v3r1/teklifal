module Administration
  class NotificationsController < BaseController

    # params to
    # params vvhen
    # params offer_id
    def sms
      @offer = Offer.find params[:offer_id]

      unless @offer.announcement.user.phone
        redirect_to params[:redirect_url], alert: "İlan sahibi telefona sahip değil"
      end
      binding.pry

      message = I18n.t(
                  "offers.new_offer_sms",
                  title: @offer.announcement.title,
                  url: announcement_url(@offer.announcement)
                )

      if :now == params.fetch(:vvhen, :now)
        Sms.send_sms to: @announcement.user.phone, message: message
      else
        SmsJob.perform_later(params[:to], message)
      end

      redirect_to params[:redirect_url]
    end

    # params mailer
    # params type
    # params params
    # params vvhen
    # params redirect_url
    # vvhen: when yani ne zaman anlaminda
    def email
      params.fetch_values(*%i(mailer type)) # raise an error if doesnt exist some key


      redirect_url = params.fetch(:redirect_url, administration_path)
      vvhen = params.fetch(:vvhen, "later")

      send_email mailer: params[:mailer],
                 params: params[:params],
                 type: params[:type],
                 vvhen: vvhen

      redirect_to redirect_url, notice: "Success!"
    end

    private

    def send_email mailer:, params:, type:, vvhen:
      mailer.
        safe_constantize.
        with(params).
        send(:"#{type}")
        send(:"deliver_#{vvhen}")
    end
  end
end