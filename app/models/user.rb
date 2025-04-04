class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts, dependent: :destroy 

  # def self.from_google(u)
  #   create_with(id: u[:uid], provider: 'google',
  #               password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  # end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]  # Google users don't need to set a password
    end
  end

  
end
