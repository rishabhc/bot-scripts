# bot-scripts
This repository contains [hubot](https://hubot.github.com/) scripts. I basically started writing these scripts to learn CoffeScript and since this is beginner code and I reinvent the wheel for some of the scripts (for my own understanding), I have not felt the need to contribute this to [hubot-scripts](https://github.com/github/hubot-scripts).

## points.coffee
I wrote this for [GeekGazette's](http://gg.ieeeiitr.com/) slack inspired by the '++' used in [SDSLabs'](https://sdslabs.co/) slack. There is already a script with the same functionality, [plusplus.coffee](https://github.com/github/hubot-scripts/blob/master/src/scripts/plusplus.coffee), but that for some reason didn't work for us at GeekGazette so I sat down to write a script of my own that did the same thing. 

### Usage
The script has the following commands:

```
<username>++ - award 1 point to <username>
<username>-- - take away 1 point from <username>
hubot score <username> - displays total points of users
hubot alias <name> <alias> - sets alias of the name
hubot unset <alias> - unsets the alias
```

We felt the need to incorporate an alias system too as we have various nicknames for each other and sometimes we accidentally used them for ++ing each other. The alias system is used as follows:
For example, people call me `rishabh` and `chhabra` both at different times so I run, `hubot alias rishabh chhabra`. Now `chhabra` is an alias of `rishabh` and any ++ done to `chhabra` (i.e. `chhabra++`) would add one point in the `rishabh` account. `hubot unset chhabra` unsets the alias.
I sometimes feel alias and points should be two different scripts, I guess I'll move the alias feature to a new script later.

### Installation 
Installation instructions can be read [here](https://github.com/github/hubot-scripts)
 
