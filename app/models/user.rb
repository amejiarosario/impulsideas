class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :projects, dependent: :destroy
  has_many :contributions

  validates :password, :confirmation => true,
            :length => {:within => 6..40},
            :allow_blank => true,
            :on => :update

  def emailname
    self.name || self.username || self.email.gsub(/@.*$/, '')
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = signed_in_resource || where(email: auth.info.email).first ||
           where(auth.slice(:provider, :uid)).first_or_initialize

    user.tap do |u|
      u.provider = auth.provider
      u.uid = auth.uid
      u.email = auth.info.email if u.email.blank?
      u.password = Devise.friendly_token[0,20] if u.encrypted_password.blank?
      u.name = auth.info.name if u.name.blank?
      u.image = auth.info.image if u.image.blank?
      u.raw_info = auth.to_yaml
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
