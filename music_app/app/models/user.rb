class User < ApplicationRecord
    validates :email, :password_digest, :session_token, presence: true
    validates :password, length: { minimum: 6 }, allow_nil: true
    before_validation :ensure_session_token
    
    attr_reader :password


    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token
        self.session_token = generate_session_token
        self.save
        self.session_token
    end

    private
    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def generate_session_token
        token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64
        end
        token
    end
end
