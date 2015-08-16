class Comment < ActiveRecord::Base
  has_closure_tree order: 'created_at ASC',
                   dependent: :nullify

  acts_as_votable

  belongs_to :user, required: true
  belongs_to :upload, required: true

  validates :upload, presence: true
  validates :user, presence: true
  validates :body, presence: true, allow_blank: false
  validates :body, length: { maximum: 1024 }
end
