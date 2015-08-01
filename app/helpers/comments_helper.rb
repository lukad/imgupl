module CommentsHelper
  def comments_tree_for(comments, upload, reply = nil)
    reply ||= Comment.new(upload: upload)
    comments.map do |comment, children|
      render comment,
             upload: upload,
             reply: reply,
             children: -> { comments_tree_for(children, upload, reply) }
    end.join.html_safe
  end
end
