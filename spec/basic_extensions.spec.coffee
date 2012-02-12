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

	describe "shift", ()->

		it "returns undefined for an empty collection.", ()->

			collection = new MutableCollection []

			expect(collection.shift()).toBeUndefined()

		it "returns the first item of a collection.", ()->

			collection = new MutableCollection [7, -3, 0, 4]

			expect(collection.shift()).toEqual 7

		it "removes the first item from the collection.", ()->

			collection = new MutableCollection [4, 2, -7, 3, 0]

			collection.shift()

			expect(collection.values()).toEqual [2, -7, 3, 0]

	describe "Push", ()->

		it "adds a value to the end of the collection.", ()->

			collection = new MutableCollection [3, -1, 0]

			collection.push -3

			expect(collection.values()).toEqual [3, -1, 0, -3]

		it "returns the new length of the collection.", ()->

			collection = new MutableCollection [3, 5, -1]

			expect(collection.push(3)).toEqual 4
