URL = require 'url'
calculateAgo = (require '../utils/time_utils').calculateAgo

getItemUrl = (item) ->
  return '/news/' + item._id.valueOf()

getUrl = (item) ->
  if (item.url)
    return item.url
  else
    return getItemUrl item

getSite = (url) ->
  URL.parse url
  .host

normalizeItem = (item) ->
  item.ago = calculateAgo item.createdOn
  item.author = 'Unknown' if not item.author?
  item.url = getUrl item
  item.site = getSite item.url
  return item

normalizeItems = (news) ->
  news.forEach (item) ->
    item = normalizeItem item
  return news

module.exports =
  normalizeItem: normalizeItem
  normalizeItems: normalizeItems