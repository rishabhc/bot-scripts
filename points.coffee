# Description:
#   Give, Take and List User Points
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <username>++ - award 1 point to <username>
#   <username>-- - take away 1 point from <username>
#   hubot score <username> - displays total points of users
#   hubot alias <name> <alias> - sets alias of the name
#   hubot unset <alias> - unsets the alias
#
# Author:
#   rishabhc
#

points = {}
aliases = {}

add_alias = (msg,name,alias) ->
	if !aliases[alias]
		aliases[alias] = name
		msg.send alias + " set as an alias of " + name
	else
		msg.send alias + " is already an alias of " + aliases[alias]

remove_alias = (msg,name) ->
	if aliases[name]
		aliases[name] = ""
		msg.send "Removed " + name
	else
		msg.send name + " is not an alias"

award_points = (msg, username, pts) ->
    if aliases[username]?
    	username = aliases[username]
    points[username] ?= 0
    points[username] += parseInt(pts)
    if(pts > 0)
        msg.send 'Level Up! ' + username + ' is now at ' + points[username]
    else if(pts < 0)
        msg.send 'Ouch! ' + username + ' is now at ' + points[username]

save = (robot) ->
    robot.brain.data.points = points
    robot.brain.data.aliases = aliases

module.exports = (robot) ->
    robot.brain.on 'loaded', ->
        points = robot.brain.data.points or {}
        aliases = robot.brain.data.aliases or {}

    robot.hear /([a-zA-Z]+(_[a-zA-Z]+)*)(\+\+)/g, (msg) ->
        from = msg.message.user.name.toLowerCase()
        i=0
        pts = 0
        to_prev = (msg.match[0].split "++")[0]
        to = to_prev
        for key in msg.match
            i++
            wordArray = key.split "++"
            to = wordArray[0]
            if(to!=to_prev)
                if(from == to_prev)
                    msg.send 'Blatant narcissism ' + from + '! You will be punished!'
                    pts = -pts
                award_points(msg,to_prev,pts)
                to_prev = to
                pts=0
            pts++
            if(i==msg.match.length)
                if(from == to)
                        msg.send 'Blatant narcissism ' + from + '! You will be punished!'
                        pts = -pts
                award_points(msg,to,pts)
        save(robot)
    
    robot.hear /([a-zA-Z]+(_[a-zA-Z]+)*)--/g, (msg) ->
        i=0
        pts = 0
        to_prev = (msg.match[0].split "--")[0]
        to = to_prev
        for key in msg.match
            i++
            wordArray = key.split "--"
            to = wordArray[0]
            if(to!=to_prev) 
                award_points(msg,to_prev,-pts)
                to_prev = to
                pts=0
            pts++
            if(i==msg.match.length)
                award_points(msg,to,-pts)
        save(robot)

    robot.respond /alias ([a-zA-Z0-9_]* [a-zA-Z0-9_]*)/i, (msg) ->
    	name = ((msg.match[0].split 'alias ')[1].split ' ')[0]
    	alias = ((msg.match[0].split 'alias ')[1].split ' ')[1]
    	add_alias(msg, name, alias)
    	save(robot)

    robot.respond /unset ([a-zA-Z0-9_]*)/i, (msg) ->
    	name = (msg.match[0].split 'unset ')[1]
    	remove_alias(msg,name)
    	save(robot)
    
    robot.respond /score (.*)/i, (msg) ->
        username = msg.match[1]
       	if aliases[username]
        	username = aliases[username]
        points[username] ?= 0
        msg.send username + ' Has ' + points[username] + ' Points'
       
