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
