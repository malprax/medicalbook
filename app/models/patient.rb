class Patient < User
  has_many :addresses, foreign_key: :user_id, dependent: :destroy
  has_one :patient_profiles, foreign_key: :user_id, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
end
