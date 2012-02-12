extend = (LiveCollection)->

	LiveCollection.addMethod "length", ()->

		@values().length

	LiveCollection.addMethod "get", (index)->

		if index < 0 or index >= @values().length

			throw new Error "Index out of range."

		@values()[index]

	LiveCollection.addMethod "first", ()->

		if @values().length is 0
			throw new Error "Index out of range."

		@values()[0]

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

		if index < 0 or index >= data.length

			throw new Error "Index out of range."

		data[index] = value
