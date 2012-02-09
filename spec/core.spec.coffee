describe "Mutable collection", ->

	MutableCollection = LiveCollection.Mutable

	it "gives access to the values of the data set it contains.", ->

		data = [1, 7, -5]

		collection = new MutableCollection data

		expect(collection.values()).toEqual data

	it "does return a clone so changes of the returned data are ignored.", ->

		data = [3, -2, 8]

		collection = new MutableCollection data

		collection.values()[1] = 5

		expect(collection.values()[1]).toEqual -2
