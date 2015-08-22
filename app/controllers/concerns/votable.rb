module Votable
  extend ActiveSupport::Concern

  included do
    before_action :load_resource, only: %i(upvote downvote unvote)
  end

  def upvote
    current_user.upvotes @resource
    render nothing: true
  end

  def downvote
    current_user.downvotes @resource
    render nothing: true
  end

  def unvote
    current_user.unvote_for @resource
    render nothing: true
  end

  private

  def load_resource
    model = controller_name.singularize.camelize.constantize
    @resource = model.find(params[:id])
  end
end
