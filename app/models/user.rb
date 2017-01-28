class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  attr_accessor :professional, :tmp_photo
  # skip_callback :commit, :after, :remove_previously_stored_government_issued_id_data
  before_create :check_professional

  def self.government_issued_id_type_list
    #code
    [
      ["Driver's License", "driver-license"],
      ["Passport", "passport"]
    ]
  end

  def check_professional
    #code
    if professional == "true"
      self.type = "Therapist"
    else
      #code
      self.type = "Patient"
    end
  end

  def self.from_omniauth(auth, extra_params)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name   # assuming the user model has a name
      user.last_name = auth.info.last_name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      if extra_params["professional"] == "true"
        user.type = "Therapist"
      else
        user.type = "Patient"
      end
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
   super.tap do |user|
     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
     end
   end
  end

  def name
   if first_name? && last_name?
     first_name + " " + last_name
   elsif first_name? && !last_name?
     first_name
   else
     email.split("@").first
   end
  end

  def is_patient?
    #code
    self.class == Patient
  end

  def is_therapist?
    #code
    self.class == Therapist
  end

  def is_admin?
    #code
    self.class == Admin
  end

  def is_super_admin?
    #code
    self.class == Admin and self.is_super_admin
  end

  def self.get_payment_method_list
    #code
    [
      ['Bank Transfer (recommended)', 'bank'],
      ['Paypal', 'paypal']
    ]
  end
end
