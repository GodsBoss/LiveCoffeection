extend = (LiveCollection)->

	throwIfIndexOutOfRange = (index)->
		if index<0 or index>=@length()
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
