class User < ActiveRecord::Base
  extend Enumerize

  acts_as_voter

  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         authentication_keys: [:login],
         reset_password_keys: [:login]

  attr_accessor :login

  enumerize :role,
            in: [:guest, :user, :mod, :admin],
            default: :guest,
            predicates: true

  has_many :uploads, dependent: :destroy
  has_many :comments

  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :role, presence: true

  scope :confirmed, -> { where('confirmed_at IS NOT NULL') }
  scope :unconfirmed, -> { where('confirmed_at IS NULL') }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    return where(conditions.to_h).where('username = :login OR email = :login', login: login).try(:first) if login
    find_by(conditions.to_h)
  end

  def confirm
    super
    update_attribute :role, :user if confirmed?
  end

  private

  def password_required?
    new_record? ? super : false
  end
end
