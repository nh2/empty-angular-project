# Top-level application
#
# Defines routes to different parts of the application.


angular.module("project", ["project.filters", "project.services", "project.utils"]).config ["$routeProvider", ($routeProvider) ->
  $routeProvider
    .when("/hello", templateUrl: "partials/hello.html", controller: "HelloCtrl")
    .when("/hello/:name", templateUrl: "partials/hello.html", controller: "HelloWithNameCtrl")
    .otherwise redirectTo: "/hello"
]


# Intialization when the app starts
app.run ($rootScope) ->
  # Put underscore into all scopes so that it can be used in templates
  $rootScope._ = _
