module Administration
  class NotificationsController < BaseController
    def sms
      
    end

    # params mailer
    # params type
    # params params
    # params vvhen
    # params redirect_url
    # vvhen: when yani ne zaman anlaminda
    def email
      params[:mail].fetch_values(*%i(mailer type)) # raise an error if doesnt exist some key

      mail_params = params[:mail]

      redirect_url = mail_params.fetch(:redirect_url, administration_path)
      vvhen = params.fetch(:vvhen, "later")

      send_email mailer: mail_params[:mailer],
                 params: mail_params[:params],
                 type: mail_params[:type],
                 vvhen: vvhen

      redirect redirect_url, notice: "Success!"
    end

    private

    def send_email mailer:, params:, type:, vvhen:
      mailer.
        safe_constantize.
        with(params).
        send(:"#{type").
        send(:"deliver_#{vvhen}")
    end
  end
end