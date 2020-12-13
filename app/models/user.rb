class User < ActiveRecord::Base
    has_many :gemstones
    has_many :comments
    has_secure_password

    validates :username, presence: true
    validates :username, uniqueness: true
end