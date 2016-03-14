timeUtils =
  calculateAgo: (date) ->
    now = new Date()
    unit = ''
    quantity = 0
    minutesAgo = Math.floor (now.getTime() - date.getTime()) / 60000
    hoursAgo = Math.floor minutesAgo / 60
    daysAgo = Math.floor hoursAgo / 24
    if daysAgo > 0
      unit = 'days'
      quantity = daysAgo
    else if hoursAgo > 0
      unit = 'hours'
      quantity = hoursAgo
    else
      unit = 'minutes'
      quantity = minutesAgo
    unit = unit.substring 0, unit.length-1 if quantity is 1
    return "#{quantity} #{unit}"

module.exports = timeUtils