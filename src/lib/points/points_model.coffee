pointsModel =
  create: (data) ->
    itemId: data.itemId
    author: data.author
    createdOn: new Date()

module.exports = pointsModel