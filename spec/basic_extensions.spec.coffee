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

			expect(collection.push 3).toEqual 4

	describe "Unshift", ()->

		it "adds a value to the beginning of the collection.", ()->

			collection = new MutableCollection [8, -4, 2]

			collection.unshift 0

			expect(collection.values()).toEqual [0, 8, -4, 2]

		it "returns the new length of the collection.", ()->

			collection = new MutableCollection [2, -8]

			expect(collection.unshift 8).toEqual 3

	describe "Clear", ()->

		it "deletes all elements.", ()->

			collection = new MutableCollection [3, -1, -3, 0, 99]

			collection.clear()

			expect(collection.values()).toEqual []

		it "returns the new length of the collection, zero.", ()->

			collection = new MutableCollection [3, 4]

			expect(collection.clear()).toEqual 0
