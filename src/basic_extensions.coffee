extend = (LiveCollection)->

	LiveCollection.addMutator "pop", (data)->

		data.pop()
