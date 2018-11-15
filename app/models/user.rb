class User < AppilcationRecord
  validates :email, :password_digest, :session_token, presence: true

  attr_reader :password

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password(password)
  end

  def self.find_by_credentials(email, password)
    email = User.find_by(email: email)
    email && email.is_password?(password) ? email : nil
        #need to find the password associated with the given email
  end

end
