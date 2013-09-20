class Csass < ActiveRecord::Base
  belongs_to :company
  belongs_to :service
  scope :payed, -> { where(subscription_type: '1') }
end
