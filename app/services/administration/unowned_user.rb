module Administration
  class UnownedUser < ActiveRecord::Base
    self.table_name = "users"

    has_one :subscriber, foreign_key: :owner_id, inverse_of: :owner, autosave: true, required: true
    accepts_nested_attributes_for :subscriber
    validates_associated :subscriber

    validates_presence_of   :email
    validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
    validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

    validates_format_of     :phone, with: /\A5[0-9]{9}\z/, allow_blank: true, if: :phone_changed?
    validates_uniqueness_of :phone, allow_blank: true, if: :phone_changed?
  end

end