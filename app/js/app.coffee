# Top-level application
#
# Defines routes to different parts of the application.


angular.module("project", ["project.filters", "project.services"]).config ["$routeProvider", ($routeProvider) ->
  $routeProvider
    .when("/hello", templateUrl: "partials/hello.html", controller: "HelloCtrl")
    .when("/hello/:name", templateUrl: "partials/hello.html", controller: "HelloWithNameCtrl")
    .otherwise redirectTo: "/hello"
]
