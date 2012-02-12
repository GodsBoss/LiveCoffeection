extend = (LiveCollection)->

	LiveCollection.addMutator "pop", (data)->

		data.pop()

	LiveCollection.addMutator "shift", (data)->

		data.shift()

	LiveCollection.addMutator "push", (data, value)->

		data.push(value)

	LiveCollection.addMutator "unshift", (data, value)->

		data.unshift value
