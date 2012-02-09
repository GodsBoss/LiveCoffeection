class Mutable
	constructor:(data)->
		@values = ->
			data.slice()
