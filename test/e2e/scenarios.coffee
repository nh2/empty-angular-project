# End-to-End browser tests
# http://docs.angularjs.org/guide/dev_guide.e2e-testing


describe "PROJECT App", ->

  it "should redirect index.html to index.html#/hello", ->
    browser().navigateTo "../../app/index.html"
    expect(browser().location().url()).toBe "/hello"

  it "should redirect index.html to index.html#/hello", ->
    browser().navigateTo "../../app/index.html#/hello/Jack"
    expect(binding('name')).toBe('Jack')
    expect(element('#greeting').text()).toBe "Hello Jack!"
