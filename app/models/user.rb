class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         authentication_keys: [:login]

  attr_accessor :login

  has_many :uploads, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }

  scope :confirmed, -> { where('confirmed_at IS NOT NULL') }
  scope :unconfirmed, -> { where('confirmed_at IS NULL') }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    return where(conditions.to_h) unless login
    where(conditions.to_h).where('username = :login OR email = :login', login: login).try(:first)
  end
end
