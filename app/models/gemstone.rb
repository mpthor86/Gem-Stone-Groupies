class Gemstone < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments

    validates :name, :properties, :source, presence: true
    validates :name, length: 1..15
    validates :properties, length: 1..35
    validates :source, length: 1..15
end