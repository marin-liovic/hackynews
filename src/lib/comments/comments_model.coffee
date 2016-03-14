commentsModel =
  create: (data) ->
    itemId: data.itemId
    text: data.text
    author: data.author
    createdOn: new Date()

module.exports = commentsModel