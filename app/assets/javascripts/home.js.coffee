# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Resource
opiniodevApp = angular.module('opiniodevApp',[])

opiniodevApp.controller 'IdeasCtrl',["$scope","$http", ($scope,$http) ->
  $http.get("/ideas.json").success (data) ->
    $scope.ideas = data
    console.log data
]

