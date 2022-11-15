class User < ApplicationRecord
    validates :email, presence: true

    attr_reader: password


    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def password=(password)
        @password = password
        password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)

    end

    def reset_session_token

    end

    private
    def ensure_session_token

    end

    def generate_session_token

    end
end
