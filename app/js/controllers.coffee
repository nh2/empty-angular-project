# Controllers


app = angular.module("project")


app.controller "HelloCtrl", ["$scope", ($scope) ->
  $scope.name = "you"
]


app.controller "HelloWithNameCtrl", ["$scope", "$routeParams", ($scope, $routeParams) ->
  $scope.name = $routeParams.name
]


app.controller "PhoneListCtrl", ["$scope", "Phone", ($scope, Phone) ->
  $scope.phones = Phone.query()
  $scope.orderProp = "age"
]


app.controller "PhoneDetailCtrl", ["$scope", "$routeParams", "Phone", ($scope, $routeParams, Phone) ->

  $scope.phone = Phone.get {phoneId: $routeParams.phoneId}, (phone) ->
    $scope.mainImageUrl = phone.images[0]

  $scope.setImage = (imageUrl) ->
    $scope.mainImageUrl = imageUrl

]
