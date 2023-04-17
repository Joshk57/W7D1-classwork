class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    has_many :cats,
    foreign_key: :owner_id, inverse_of: :owner,
    class_name: :User

    has_many :requests,
    foreign_key: :requester_id, inverse_of :requester,
    class_name: :CatRentalRequest,
    dependent: :destroy


    before_validation :ensure_session_token
    attr_reader :password

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    private
    def generate_unique_session_token
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end


    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end
end
