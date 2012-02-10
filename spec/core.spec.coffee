MutableCollection = LiveCollection.Mutable

includeDataAccess = (data, collection)->

	it "gives access to the values of the data set it contains.", ->

		expect(collection.values()).toEqual data

	it "does return a clone so changes of the returned data are ignored.", ->

		firstValue = data[0]
		collection.values()[0] = !data[0]

		expect(collection.values()[0]).toEqual firstValue

describe "Mutable collection", ->

	data = [1, -5, 3]

	collection = new MutableCollection data

	includeDataAccess data, collection

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

describe "A transformation method", ()->

	it "does not call the transformer without a call to values().", ()->

		called = false
		LiveCollection.addTransformer "notCalled", ()->

		expect(called).toBeFalsy()

	it "passes the arguments to the transform callback.", ()->

		transformArgs = null
		callArgs = [-4, 0, 2]
		LiveCollection.addTransformer "storeArgs", (args...)->
			transformArgs = args

		collection = new MutableCollection []
		transformedCollection = collection.storeArgs.apply collection, callArgs
		transformedCollection.values()

		expect(transformArgs).toEqual callArgs

	it "is called within the context of the collection.", ()->

		thisValue = null
		LiveCollection.addTransformer "storeThis", ()->
			thisValue = @
			[]

		collection = new MutableCollection []
		collection.storeThis().values()

		expect(thisValue).toEqual collection

	describe "Collection created via a transform method", ()->

		data = [8, 3, 0]
		LiveCollection.addTransformer "transform", ()->
			data

		collection = new MutableCollection []

		includeDataAccess data, collection.transform()
