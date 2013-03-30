# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Resource
window.OpinioDev.controllers.controller 'searchCtrl',["$scope","$http", ($scope,$http) ->
  $http.get("/ideas.json").success (data) ->
    $scope.ideas = data

  $scope.new_idea = {}
  $("#idea_search").keyup( ()->
    $http.get("/ideas/search.json?q="+$scope.new_idea.title).success (data) ->
      $scope.ideas = data
  )

  $scope.addIdea = ->
    $scope.ideas.push
      title: $scope.new_idea.title
      description: $scope.new_idea.description

    $http.post("/ideas.json",{"idea":$scope.new_idea}).success (data)->
      console.log data

    $scope.new_idea.title = ""
    $scope.new_idea.description = ""

]

