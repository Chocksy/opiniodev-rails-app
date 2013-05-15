window.OpinioDev.controller 'ideaCtrl',["$scope","$rootScope","$http","Idea", ($scope,$rootScope,$http,Idea) ->
  #init variables
  $scope.idea        = {_id:$('#idea').val(),votes:$('#idea_votes').val()}

  console.log $scope.idea

  $scope.like = ()->
    $scope.idea.votes = parseInt($scope.idea.votes)+1
    new Idea({id:$scope.idea._id,votes:$scope.idea.votes}).update()

  $scope.dislike = ()->
    #if $scope.idea.votes>0
      $scope.idea.votes = parseInt($scope.idea.votes)-1
      new Idea({id:$scope.idea._id,votes:$scope.idea.votes}).update()
]

