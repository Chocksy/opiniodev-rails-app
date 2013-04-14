window.OpinioDev = angular.module "OpinioDev", ["rails"]

window.OpinioDev.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]


window.OpinioDev.controller "mainController", ["$scope","$rootScope","User",($scope,$rootScope,User)->

  getUser = ()->
    $rootScope.user = {_id:$("#current_user").val()}
    if $rootScope.user._id
      User.get($rootScope.user._id).then((result)->
        console.log result
        $scope.user = result
        $rootScope.$broadcast("gotUser")
      )

  getUser()
]

window.OpinioDev.directive "noHref", ->
  (scope, element, attrs) ->
    $(element).click (event) ->
      event.preventDefault()
