describe "Mutable collection", ->

	MutableCollection = LiveCollection.Mutable

	it "gives access to the values of the data set it contains.", ->

		data = [1, 7, -5]

		collection = new MutableCollection data

		expect(collection.values()).toEqual data
