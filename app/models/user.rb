class User < ActiveRecord::Base
    has_many :gemstones
    has_secure_password

    validates :username, uniqueness: true
end