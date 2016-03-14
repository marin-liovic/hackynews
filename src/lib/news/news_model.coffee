_ = require 'lodash'
SHOW_TITLE = 'Show HN'
ASK_TITLE = 'Ask HN'
SPECIAL_TITLES = [SHOW_TITLE, ASK_TITLE]

normalizeTitle = (title) ->
  _.each SPECIAL_TITLES, (titlePrefix) ->
    if _.startsWith title.toLowerCase(), titlePrefix.toLowerCase()
      title = "#{titlePrefix}#{title.substring titlePrefix.length, title.length}"
      return false
  return title

normalizeUrl = (url) ->
  if (url && !/^(?:f|ht)tps?\:\/\//.test url)
    url = 'http://' + url
  return url

newsModel =
  SHOW_TITLE: SHOW_TITLE
  ASK_TITLE: ASK_TITLE
  create: (data) ->
    item =
      title: normalizeTitle data.title
      url: normalizeUrl data.url
      points: 0
      author: data.author
      createdOn: new Date()
    item.text = data.text if not item.url
    return item

module.exports = newsModel