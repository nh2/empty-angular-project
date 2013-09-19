# Directives


app = angular.module("project")


# Loads the script given in the 'src' property if the browser is on 'localhost'.
#
# Usage:
#   <div dev-script src="path/to/my/script"></div>
app.directive "devScript",  [->
  (scope, element, attrs) ->
    if window.location.hostname != 'localhost'
      return

    console.log 'Injecting development script:', src

    # Can't use jQuery's getScript() because that calls eval, not <script> DOM insertion,
    # and some things (like vogue) rely on having their own script tag.
    script = document.createElement 'script'
    script.src = src
    document.body.appendChild script
]


# Loads vogue from the same hostname as the browser is on (but vogue port 8001).
# If the property 'only-localhost' is 'true', it will only execute if the browser is on localhost
#
# Usage:
#   <div inject-vogue></div>
app.directive "injectVogue",  [->

  (scope, element, attrs) ->
    if attrs.onlyLocalhost == 'true' and window.location.hostname != 'localhost'
      return

    # Inject vogue with the same hostname as the current page.
    origin = window.location.protocol + '//' + window.location.hostname # without port!
    src = "#{origin}:8001/vogue-client.js"

    console.log 'Injecting vogue:', src

    script = document.createElement 'script'
    script.src = src
    document.body.appendChild script
]



# Updates a variable when the window scrollTop position is changed.
# Usage:
#   <set-window-scroll set-variable="windowScroll"></set-window-scroll>
app.directive "setWindowScroll", ->
  restrict: "E"
  scope:
    setVariable: "="

  link: (scope) ->
    # Throttle to 300ms so that we don't call $apply so often.
    throttled = _.throttle ->
      # Need to call $apply here since we are changing the scope *asynchronously* (in scroll callback).
      # See http://www.bennadel.com/blog/2449-Directive-Link-observe-And-watch-Functions-Execute-Inside-An-AngularJS-Context.htm
      scope.$apply ->
        scope.setVariable = $(window).scrollTop()
    , 300
    $(window).scroll throttled


# Changes the width of an <input type="text"> element automatically to fit its contents.
#
# Sets the width to (#numberOfChars + 1) ex.
app.directive "autosize", ->
  restrict: "A"

  link: (scope, elem, attrs) ->
    scope.$watch attrs.ngModel, (newVal, oldVal) ->
      size = newVal.length or 0
      elem.css width: "#{size+1}ex"
