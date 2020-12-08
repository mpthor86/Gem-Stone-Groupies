class User < ActiveRecord::Base
    has_many :gemstones
    has_secure_password
end