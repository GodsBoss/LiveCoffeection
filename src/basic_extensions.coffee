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

	LiveCollection.addMutator "pop", (data)->
		data.pop()

	LiveCollection.addMutator "shift", (data)->
		data.shift()

	LiveCollection.addMutator "push", (data, value)->
		data.push value

	LiveCollection.addMutator "unshift", (data, value)->
		data.unshift value

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
