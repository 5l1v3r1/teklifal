class UserCarrier
  include ActiveModel::Validations

  validates_presence_of :email
  

  def initialize

  end

end