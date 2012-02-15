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

	describe "Join", ()->

		it "returns an empty string for an empty collection.", ()->
			collection = new MutableCollection []
			expect(collection.join()).toEqual ""

		it "uses a comma as standard separator.", ()->
			collection = new MutableCollection [5, 2, 0]
			expect(collection.join()).toEqual "5,2,0"

		it "lets the client choose another separator.", ()->
			collection = new MutableCollection [8, 2, 0]
			expect(collection.join "; ").toEqual "8; 2; 0"

	describe "Contains", ()->

		it "returns false if the item is not contained in the collection.", ()->
			collection = new MutableCollection [false, null, 1]
			expect(collection.contains 0).toEqual false

		it "returns true if the item is contained in the collection.", ()->
			collection = new MutableCollection [8, "hello"]
			expect(collection.contains 8).toEqual true

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

		it "removes an item.", ()->
			collection = new MutableCollection [3, 5, -2, 8, 9]
			collection.remove 3
			expect(collection.values()).toEqual [3, 5, -2, 9]

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

		it "inserts the element after the given index.", ()->
			collection = new MutableCollection [2, 8, -4, -5]
			collection.insertAfter 2, 0
			expect(collection.values()).toEqual [2, 8, -4, 0, -5]

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

		it "inserts the given value before the position of index.", ()->
			collection = new MutableCollection [3, -8, -9]
			collection.insertBefore 1, 5
			expect(collection.values()).toEqual [3, 5, -8, -9]

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

	describe "Replace", ()->

		it "replaces all items with the given values.", ()->
			collection = new MutableCollection [7, 3, 8, 2, 0, 9]
			collection.replace 2, [-4, -5]
			expect(collection.values()).toEqual [7, 3, -4, -5, 0, 9]

		it "extends the collection if the replacement item list exceeds it.", ()->
			collection = new MutableCollection [5, -2, -5, 0]
			collection.replace 2, [8, -1, 3, 6]
			expect(collection.values()).toEqual [5, -2, 8, -1, 3, 6]

		it "appends the list if the index is directly after the last item.", ()->
			collection = new MutableCollection [3, 9]
			collection.replace 2, [-1, 0]
			expect(collection.values()).toEqual [3, 9, -1, 0]

		it "throws 'Index out of range.' if the index is negative.", ()->
			collection = new MutableCollection [5]
			tryToReplaceWithNegativeIndex = ()->
				collection.replace -1, [5, 6]
			expect(tryToReplaceWithNegativeIndex).toThrow "Index out of range."

		it "throws 'Index out of range.' if the index is too high.", ()->
			collection = new MutableCollection [0, 4, 2]
			tryToReplaceWithIndexTooHigh = ()->
				collection.replace 4, [-9, -8]
			expect(tryToReplaceWithIndexTooHigh).toThrow "Index out of range."

describe "Standard transformations.", ()->

	values = [-4, 0, 8, -3, 3, 9]
	collection = null

	beforeEach ()->
		collection = new MutableCollection values

	describe "Head", ()->

		it "returns an empty collection if zero elements are desired.", ()->
			expect(collection.head(0).values()).toEqual []

		it "takes the first items of a collection.", ()->
			expect(collection.head(2).values()).toEqual values[0..1]

		it "takes all items if more are to be taken than are contained.", ()->
			expect(collection.head(10).values()).toEqual values

	describe "Tail", ()->

		it "returns an empty collection if zero elements are desired.", ()->
			expect(collection.tail(0).values()).toEqual []

		it "takes the last items of a collection.", ()->
			expect(collection.tail(3).values()).toEqual values[-3..]

		it "takes all items if more are to be taken than are contained.", ()->
			expect(collection.tail(8).values()).toEqual values

	describe "Reverse", ()->

		it "returns the collection in reverse order.", ()->
			reversedValues = values.slice().reverse()
			expect(collection.reverse().values()).toEqual reversedValues

	describe "Map", ()->

		it "converts every element according to the given function.", ()->
			f = (n)->
				n*n
			squaredValues = values.map f
			expect(collection.map(f).values()).toEqual squaredValues

		it "is called in an optional context.", ()->
			obj = {}
			allThissAreObj = true
			f = (x)->
				if @ isnt obj
					allThissAreObj = false
			collection.map(f, obj).values()
			expect(allThissAreObj).toBeTruthy()

	it "lets the callback be called with the index as second argument.", ()->
		secondArgs = []
		f = (value, index)->
			secondArgs.push index
		collection.map(f).values()
		expect(secondArgs).toEqual [0..values.length-1]

	it "lets the callback be called with the collection as third argument.", ()->
		allThirdArgumentsAreTheCollection = true
		f = (value, index, thirdArg)->
			if thirdArg isnt collection
				allThirdArgumentsAreTheCollection = false
			value
		collection.map(f).values()
		expect(allThirdArgumentsAreTheCollection).toBeTruthy()

	describe "Filter", ()->

		it "contains only the elements for which the predicate holds true.", ()->
			even = (n)->
				n % 2 == 0
			expect(collection.filter(even).values()).toEqual values.filter even

		it "lets the predicate be called with the index as second argument.", ()->
			secondArgs = []
			pred = (value, index)->
				secondArgs.push index
			collection.filter(pred).values()
			expect(secondArgs).toEqual [0..values.length-1]

		it "is called within an optional context.", ()->
			context = {}
			allThisValuesWereContext = true
			pred = ()->
				if @ isnt context
					allThisValuesWereContext = false
			collection.filter(pred, context).values()
			expect(allThisValuesWereContext).toBeTruthy()

		it "lets the predicate be called with the collection as third arg.", ()->
			allThirdArgumentsWereTheCollection = true
			pred = (value, index, thirdArgument)->
				if thirdArgument isnt collection
					allThirdArgumentsWereTheCollection = false
			collection.filter(pred).values()
			expect(allThirdArgumentsWereTheCollection).toBeTruthy()
