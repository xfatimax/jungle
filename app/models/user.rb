class User < ApplicationRecord

  has_secure_password
  
  validates :first_name, presence: true, length: { minimum:1 }
  validates :last_name, presence: true, length: { minimum:1 }
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum:8 }
  validates :password_confirmation, presence: true, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
        return user
      else 
       nil
      end
  end
  
end
