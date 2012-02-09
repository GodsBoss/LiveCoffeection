class Mutable
	constructor:(data)->
		@values = ->
			data.slice()

addMethod = (name, callback)->
	Mutable::[name] = (args...)->
		callback.apply @, args
