# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Resource
window.OpinioDev.controllers.controller 'searchCtrl',["$scope","$http","Idea", ($scope,$http,Idea) ->
  $scope.ideas = Idea.query()

  console.log Idea.total_ideas()

  $scope.new_idea = {}
  $("#idea_search").keyup( ()->
    $http.get("/ideas/search.json?q="+$scope.new_idea.title).success (data) ->
      $scope.ideas = data
  )

  $scope.addIdea = ->

    Idea.save $scope.new_idea, ()->
      $scope.ideas = Idea.query()

    $scope.new_idea.title = ""
    $scope.new_idea.description = ""

]

