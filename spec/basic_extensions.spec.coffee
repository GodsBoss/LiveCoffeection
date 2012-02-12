MutableCollection = LiveCollection.Mutable

describe "Standard mutators", ()->

	describe "Pop", ()->

		it "returns undefined for an empty collection.", ()->

			collection = new MutableCollection []

			expect(collection.pop()).toBeUndefined()

		it "returns the last item of a collection with values.", ()->

			collection = new MutableCollection [-8, 2, 5]

			expect(collection.pop()).toEqual 5

		it "removes the last item from the collection.", ()->

			collection = new MutableCollection [3, 6, -2, 1]

			collection.pop()

			expect(collection.values()).toEqual [3, 6, -2]
