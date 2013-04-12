# jasmine specs for filters go here


describe "filter", ->

  beforeEach module("project.filters")

  describe "checkmark", ->
    it "should convert boolean values to unicode checkmark or cross", inject((checkmarkFilter) ->
      expect(checkmarkFilter(true)).toBe "✓"
      expect(checkmarkFilter(false)).toBe "✘"
    )

