class PatientProfile < ApplicationRecord
  belongs_to :patient, class_name: "Patient", foreign_key: :user_id
end
