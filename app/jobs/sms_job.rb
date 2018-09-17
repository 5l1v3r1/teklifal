class SmsJob < ApplicationJob
  queue_as :default

  def perform phone, message
    Sms.send_sms to: phone, message: message
  end
end
