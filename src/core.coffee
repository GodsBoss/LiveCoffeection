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

addMethod = (name, callback)->
	Mutable::[name] = (args...)->
		callback.apply @, args
	ReadOnly::[name] = (args...)->
		callback.apply @, args

addMutator = (name, callback)->
	Mutable::[name] = (args...)->
		callback.apply @, [@_data].concat args

addTransformer = (name, transform)->
	Mutable::[name] = (args...)->
		new ReadOnly @, transform, args
