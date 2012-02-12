extend = (LiveCollection)->

	LiveCollection.addMutator "pop", (data)->

		data.pop()

	LiveCollection.addMutator "shift", (data)->

		data.shift()
