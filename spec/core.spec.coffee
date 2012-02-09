MutableCollection = LiveCollection.Mutable

describe "Mutable collection", ->

	it "gives access to the values of the data set it contains.", ->

		data = [1, 7, -5]

		collection = new MutableCollection data

		expect(collection.values()).toEqual data

	it "does return a clone so changes of the returned data are ignored.", ->

		data = [3, -2, 8]

		collection = new MutableCollection data

		collection.values()[1] = 5

		expect(collection.values()[1]).toEqual -2

describe "An extension method", ()->

	collection = null
	argumentLists = null
	thisValue = null
	returnValue = null

	beforeEach ()->
		argumentLists = []

		LiveCollection.addMethod "someMethod", (args...)->
			thisValue = @
			argumentLists.push args
			returnValue

		collection = new MutableCollection []

	it "is added to mutable collections.", ()->

		expect(typeof collection.someMethod).toEqual "function"

	it "is called once when the collection's method is called once.", ()->

		collection.someMethod()

		expect(argumentLists.length).toEqual 1

	it "is called with the collection's method's call's arguments.", ()->

		collectionCallArgs = [3, -4, 1, 0]

		collection.someMethod.apply collection, collectionCallArgs

		expect(argumentLists[0]).toEqual collectionCallArgs

	it "lets the collection's method return a result.", ()->

		returnValue = "return"

		result = collection.someMethod()

		expect(result).toEqual returnValue

	it "is called in the context of the collection.", ()->

		collection.someMethod()

		expect(thisValue).toEqual collection

describe "A mutator", ()->

	it "can change the data.", ()->

		LiveCollection.addMutator "changeSecondElementToFive", (data)->
			data[1] = 5

		collection = new MutableCollection [-8, 3, 6]
		collection.changeSecondElementToFive()

		expect(collection.values()[1]).toEqual 5

	it "takes arguments.", ()->

		LiveCollection.addMutator "changeFirstElementToSumOf", (data, a, b)->
			data[0] = a+b

		collection = new MutableCollection [3, 9, 0]
		collection.changeFirstElementToSumOf -5, 2

		expect(collection.values()[0]).toEqual -3

	it "returns the return value of the mutator callback.", ()->

		returnValue = "Return value"

		LiveCollection.addMutator "justReturn", ()->
			returnValue

		collection = new MutableCollection []
		expect(collection.justReturn()).toEqual returnValue

	it "is called within the context of the collection.", ()->

		thisValue = null

		LiveCollection.addMutator "storeThis", ()->
			thisValue = @

		collection = new MutableCollection []
		collection.storeThis()
		expect(thisValue).toEqual collection
