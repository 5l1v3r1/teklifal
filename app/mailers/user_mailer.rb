class UserMailer < ApplicationMailer
  def new_offer
    @offer = params[:offer]
    @ann = @offer.announcement
    mail from: "admin@example.com",
         to: @ann.user.email,
         subject: "'#{@ann.title}' ilanınıza yeni teklif var"
  end
end
