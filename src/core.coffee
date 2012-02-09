class Mutable
	constructor:(data)->

		@_data = data

		@values = ->
			data.slice()

addMethod = (name, callback)->
	Mutable::[name] = (args...)->
		callback.apply @, args

addMutator = (name, callback)->
	Mutable::[name] = (args...)->
		callback.apply @, [@_data].concat args

addTransformer = (name, transform)->
	Mutable::[name] = (args...)->
		obj = @
		values:()->
			transform.apply obj, args
