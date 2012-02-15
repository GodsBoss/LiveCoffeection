extend = (LiveCollection)->

	throwIfIndexOutOfRange = (index, lesserBound = 0, upperBound = @length())->
		if index<lesserBound or index>=upperBound
			throw new Error "Index out of range."

	LiveCollection.addMethod "length", ()->
		@values().length

	LiveCollection.addMethod "get", (index)->
		throwIfIndexOutOfRange.call @, index
		@values()[index]

	LiveCollection.addMethod "first", ()->
		@get 0

	LiveCollection.addMethod "last", ()->
		@get @length() - 1

	LiveCollection.addMethod "join", (separator = ",")->
		@values().join(separator)

	LiveCollection.addMethod "contains", (item)->
		item in @values()

	LiveCollection.addMethod "every", (predicate, context = null)->
		values = @values()
		if values.length > 0
			for index in [0..values.length-1]
				if not predicate.call context, values[index], index, @
					return false
		true

	LiveCollection.addMethod "some", (predicate, context = null)->
		values = @values()
		for index in [0..values.length-1]
			if predicate.call context, values[index], index, @
				return true
		false

	for mutator in ["pop", "shift", "push", "unshift"]
		LiveCollection.addMutator mutator, ((m)->
			(data, args...)->
				data[m].apply data, args)(mutator)

	LiveCollection.addMutator "clear", (data)->
		data.length = 0

	LiveCollection.addMutator "set", (data, index, value)->
		throwIfIndexOutOfRange.call @, index
		data[index] = value

	LiveCollection.addMutator "remove", (data, index)->
		throwIfIndexOutOfRange.call @, index
		data[index..data.length-1]=data[index+1..data.length-1].concat [data[index]]
		data.pop()

	LiveCollection.addMutator "insertAfter", (data, index, value)->
		throwIfIndexOutOfRange.call @, index, -1
		data[index+1..data.length]=[value].concat data[index+1..data.length-1]
		data.length

	LiveCollection.addMutator "insertBefore", (data, index, value)->
		throwIfIndexOutOfRange.call @, index, 0, data.length+1
		data[index..data.length]=[value].concat data[index..data.length-1]
		data.length

	LiveCollection.addMutator "replace", (data, index, values)->
		throwIfIndexOutOfRange.call @, index, 0, data.length+1
		data[index..index+values.length-1] = values

	LiveCollection.addTransformer "head", (length)->
		@values().slice 0, length

	LiveCollection.addTransformer "tail", (length)->
		@values().slice Math.max 0, @values().length-length

	LiveCollection.addTransformer "reverse", ()->
		@values().reverse()

	LiveCollection.addTransformer "map", (f, thisArg = null)->
		values = @values()
		for index in [0..values.length-1]
			f.call thisArg, values[index], index, @

	LiveCollection.addTransformer "filter", (p, context = null)->
		result = []
		values = @values()
		for index in [0..values.length-1]
			if p.call context, values[index], index, @
				result.push values[index]
		result
