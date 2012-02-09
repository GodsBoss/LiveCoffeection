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

	it "is added to mutable collections.", ()->

		LiveCollection.addMethod "someMethod", ()->

		collection = new MutableCollection []

		expect(typeof collection.someMethod).toEqual "function"

	it "is called once when the collection's method is called once.", ()->

		calls = 0
		LiveCollection.addMethod "addCall", ()->
			calls++

		collection = new MutableCollection []
		collection.addCall()

		expect(calls).toEqual 1

	it "is called with the collection's method's call's arguments.", ()->

		collectionCallArgs = [3, -4, 1, 0]
		callbackCallArgs = null
		LiveCollection.addMethod "saveArguments", (args...)->
			callbackCallArgs = args

		collection = new MutableCollection []
		collection.saveArguments.apply collection, collectionCallArgs

		expect(callbackCallArgs).toEqual collectionCallArgs

	it "lets the collection's method return a result.", ()->

		returnValue = "return"
		LiveCollection.addMethod "returnSomething", ()->
			returnValue

		collection = new MutableCollection []
		result = collection.returnSomething()

		expect(result).toEqual returnValue

	it "is called in the context of the collection.", ()->

		collection = new MutableCollection []
		LiveCollection.addMethod "returnThis", ()->
			@

		expect(collection.returnThis()).toEqual collection
