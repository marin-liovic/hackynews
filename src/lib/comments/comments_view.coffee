calculateAgo = (require '../utils/time_utils').calculateAgo

commentsView =
  normalizeComments: (comments) ->
    comments.forEach (comment) ->
      comment.ago = calculateAgo comment.createdOn
    return comments

module.exports = commentsView