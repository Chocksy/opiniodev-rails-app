window.OpinioDev.controller 'searchCtrl',["$scope","$http","Idea", ($scope,$http,Idea) ->
  Idea.query({},(data)->
    $scope.ideas        = data.ideas
    $scope.total_ideas  = data.total_ideas
  )

  $scope.new_idea = {}
  $("#idea_search").keyup( ()->
    Idea.search({q:$scope.new_idea.title},(data) ->
      $scope.ideas        = data.ideas
      $scope.total_ideas  = data.total_ideas
    )
  )

  $scope.addIdea = ->

    Idea.save $scope.new_idea, ()->
      $scope.ideas = Idea.query()

    $scope.new_idea.title = ""
    $scope.new_idea.description = ""

]

