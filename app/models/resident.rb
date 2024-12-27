class Resident < ApplicationRecord
  has_one :contact_detail
  has_one :emergency_contact
  has_one :stay_detail
  has_one :proof_of_id
  has_many :payments

  accepts_nested_attributes_for :contact_detail,
                                :emergency_contact,
                                :stay_detail,
                                :proof_of_id,
                                :payments
end
