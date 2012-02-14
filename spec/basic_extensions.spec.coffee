MutableCollection = LiveCollection.Mutable

describe "Standard methods", ()->

	describe "Length", ()->

		it "returns zero for an empty collection.", ()->
			collection = new MutableCollection []
			expect(collection.length()).toEqual 0

		it "returns the length of a collection.", ()->
			collection = new MutableCollection [3, -1, 0, 2, 5]
			expect(collection.length()).toEqual 5

	describe "Get", ()->

		it "returns the value of an item.", ()->
			collection = new MutableCollection [-6, 7, 3, 4]
			expect(collection.get 2).toEqual 3

		it "throws 'Index out of range.' for negative indizes.", ()->
			collection = new MutableCollection [-2, 0]
			tryToGetWithNegativeIndex = ()->
				collection.get -3

			expect(tryToGetWithNegativeIndex).toThrow "Index out of range."

		it "throws 'Index out of range.' for an index too high.", ()->
			collection = new MutableCollection [6, -8, 3 ,0]
			tryToGetWithIndexTooHigh = ()->
				collection.get 4
			expect(tryToGetWithIndexTooHigh).toThrow "Index out of range."

	describe "First", ()->

		it "throws 'Index out of range.' for an empty collection.", ()->
			collection = new MutableCollection []
			tryToGetFirstFromEmptyCollection = ()->
				collection.first()
			expect(tryToGetFirstFromEmptyCollection).toThrow "Index out of range."

		it "returns the first value of a non-empty collection.", ()->
			collection = new MutableCollection [3, 8, -2]
			expect(collection.first()).toEqual 3

	describe "Last", ()->

		it "throws 'Index out of range.' for an empty collection.", ()->
			collection = new MutableCollection []
			tryToGetLastFromEmptyCollection = ()->
				collection.last()
			expect(tryToGetLastFromEmptyCollection).toThrow "Index out of range."

		it "returns the last value of a non-empty collection.", ()->
			collection = new MutableCollection [6, -3, 0, 4]
			expect(collection.last()).toEqual 4

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

	describe "Set", ()->

		it "sets the value of an item.", ()->
			collection = new MutableCollection [-8, 7, 3, 9]
			collection.set 1, 5
			expect(collection.values()[1]).toEqual 5

		it "throws 'Index out of range.' if index is too low.", ()->
			collection = new MutableCollection [4, 5]
			tryToSetWithNegativeIndex = ()->
				collection.set -3, 5
			expect(tryToSetWithNegativeIndex).toThrow "Index out of range."

		it "throws 'Index out of range.', if index is too high.", ()->
			collection = new MutableCollection [2, -6, 3]
			tryToSetWithIndexTooHigh = ()->
				collection.set 3, 0
			expect(tryToSetWithIndexTooHigh).toThrow "Index out of range."

	describe "Remove", ()->

		it "lets all items before the removed item unchanged.", ()->
			collection = new MutableCollection [3, 5, -2, 8, 9]
			collection.remove 3
			expect(collection.values().slice 0, 3).toEqual [3, 5, -2]

		it "moves all items after the removed item to avoid a gap.", ()->
			collection = new MutableCollection [-4, 2, 0, 8, 3]
			collection.remove 2
			expect(collection.values().slice 2).toEqual [8, 3]

		it "returns the item which was removed.", ()->
			collection = new MutableCollection [5, 3, -9, 0, -2]
			expect(collection.remove 2).toEqual -9

		it "throws 'Index out of range.' if index is negative.", ()->
			collection = new MutableCollection []
			tryToRemoveItemWithNegativeIndex = ()->
				collection.remove -2
			expect(tryToRemoveItemWithNegativeIndex).toThrow "Index out of range."

		it "throws 'Index out of range.' if index is too high.", ()->
			collection = new MutableCollection [-8, -3, -4]
			tryToRemoveItemWithIndexTooHigh = ()->
				collection.remove 4
			expect(tryToRemoveItemWithIndexTooHigh).toThrow "Index out of range."

	describe "Insert after", ()->

		it "lets all items before the inserted element unchanged.", ()->
			collection = new MutableCollection [3, 6, -8, 0]
			collection.insertAfter 1, 5
			expect(collection.values().slice 0, 2).toEqual [3, 6]

		it "moves all subsequent elements to a position with a higher index.", ()->
			collection = new MutableCollection [7, -3, -4, 1]
			collection.insertAfter 1, 6
			expect(collection.values().slice 3).toEqual [-4, 1]

		it "inserts the element after the given index.", ()->
			collection = new MutableCollection [2, 8, -4, -5]
			collection.insertAfter 2, 0
			expect(collection.values()[3]).toEqual 0

		it "returns the new length of the collection.", ()->
			collection = new MutableCollection [3, 6, 2]
			expect(collection.insertAfter 1, 9).toEqual 4

		it "allows inserting after an index of -1.", ()->
			collection = new MutableCollection [3, 6]
			collection.insertAfter -1, 8
			expect(collection.values()[0]).toEqual 8

		it "throws 'Index out of range.' for an index lesser than -1.", ()->
			collection = new MutableCollection []
			tryToInsertAfterIndexTooLow = ()->
				collection.insertAfter -2, 5
			expect(tryToInsertAfterIndexTooLow).toThrow "Index out of range."

		it "throws 'Index out of range.' for an index too high.", ()->
			collection = new MutableCollection [-5, 8, 0]
			tryToInsertAfterIndexTooHigh = ()->
				collection.insertAfter 3, 7
			expect(tryToInsertAfterIndexTooHigh).toThrow "Index out of range."

	describe "Insert before", ()->

		it "leaves items before the inserted element untouched.", ()->
			collection = new MutableCollection [6, -7, 2, 3, 9]
			collection.insertBefore 3, 5
			expect(collection.values().slice 0, 3).toEqual [6, -7, 2]

		it "moves subsequent items to a higher index.", ()->
			collection = new MutableCollection [0, 4, -2, 9, 1]
			collection.insertBefore 2, -7
			expect(collection.values().slice 3).toEqual [-2, 9, 1]

		it "inserts the given value before the position of index.", ()->
			collection = new MutableCollection [3, -8, -9]
			collection.insertBefore 1, 5
			expect(collection.values()[1]).toEqual 5

		it "inserts an item even before the index after the last index.", ()->
			collection = new MutableCollection [4, 0, -3]
			collection.insertBefore 3, 9
			expect(collection.values()[3]).toEqual 9

		it "throws 'Index out of range.' for a negative index.", ()->
			collection = new MutableCollection [6, -2]
			tryToInsertBeforeNegativeIndex = ()->
				collection.insertBefore -1, 5
			expect(tryToInsertBeforeNegativeIndex).toThrow "Index out of range."

		it "throws 'Index out of range.' for an index too high.", ()->
			collection = new MutableCollection [7, 4, -5]
			tryToInsertBeforeIndexTooHigh = ()->
				collection.insertBefore 4, 9
			expect(tryToInsertBeforeIndexTooHigh).toThrow "Index out of range."

		it "returns the new length of the collection.", ()->
			collection = new MutableCollection [5, 2, 0, 3]
			expect(collection.insertBefore 2, 8).toEqual 5
