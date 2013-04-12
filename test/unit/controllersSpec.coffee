# jasmine specs for controllers go here


describe "PROJECT controllers", ->

  beforeEach ->
    @addMatchers toEqualData: (expected) ->
      angular.equals @actual, expected

  # Load modules required for this test
  beforeEach module("project")
  beforeEach module("project.services")


  describe "HelloCtrl", ->

    controller = undefined
    beforeEach inject(($controller) -> controller = $controller)

    it "should set the default value of orderProp model", ->
      scope = {}
      controller("HelloCtrl", $scope: scope)
      expect(scope.name).toBe "you"
