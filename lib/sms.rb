require 'iletimerkezisms'

class Sms
  @@username = Rails.application.credentials[:iletimerkezi][:username]
  @@password = Rails.application.credentials[:iletimerkezi][:password]

  def self.send_sms to:, message:
    unless Rails.env.test?
      response = IletimerkeziSMS.send(@@username, @@password, {
        sender: "ILETI MRKZI",
        message: message,
        numbers: [to]
      })


      log response
    end
  end

  def self.balance
    IletimerkeziSMS.balance(@@username, @@password)["balance"]["sms"]
  end

  def self.log response
    case response["status"]["code"].to_i
    when 110..200
      Rails.logger.info "SMS RESPONSE: #{response.inspect}"
    when 400..503
      Rails.logger.error "SMS RESPONSE: #{response.inspect}"
    end
  end

end