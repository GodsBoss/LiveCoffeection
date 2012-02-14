class Mutable
	constructor:(data)->

		@_data = data

		@values = ->
			data.slice()

class ReadOnly
	constructor:(parentCollection, transform, args)->

		@values = ->
			result = transform.apply parentCollection, args
			result.slice()

addToBoth = (name, callback)->
	Mutable::[name] = callback
	ReadOnly::[name] = callback

addMethod = (name, method)->
	addToBoth name, (args...)->
		method.apply @, args

addMutator = (name, mutate)->
	Mutable::[name] = (args...)->
		mutate.apply @, [@_data].concat args

addTransformer = (name, transform)->
	addToBoth name, (args...)->
		new ReadOnly @, transform, args
