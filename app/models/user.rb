class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :projects, dependent: :destroy
  has_many :contributions

  def emailname
    self.name || self.username || self.email.gsub(/@.*$/, '')
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = where(email: auth.info.email).first ||
           where(auth.slice(:provider, :uid)).first_or_initialize

    user.tap do |u|
      u.provider = auth.provider unless u.provider
      u.uid = auth.uid unless u.uid
      u.email = auth.info.email unless u.email
      u.password = Devise.friendly_token[0,20] unless u.password
      u.name = auth.info.name unless u.name
      u.image = auth.info.image unless u.image
      u.raw_info = auth.to_yaml
      u.save!
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
