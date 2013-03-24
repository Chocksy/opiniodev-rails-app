# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Resource
angular.module('Ideas',[]).controller('IdeasCtrl', ($scope,$http) ->
  $http.get("/ideas.json").success (data) ->
    $scope.ideas = data
    console.log data
)
