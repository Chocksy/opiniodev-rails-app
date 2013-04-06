window.OpinioDev.controller 'searchCtrl',["$scope","$http","Idea", ($scope,$http,Idea) ->
  #init variables
  $scope.page        = 1
  $scope.per_page    = 3
  $scope.total_ideas = $scope.page*$scope.per_page

  goTop = ->
    $("html, body").animate({ scrollTop: 0 }, "slow")

  getIdeas = ()->
    Idea.query({page:$scope.page,per_page:$scope.per_page},(data)->
               $scope.ideas        = data.ideas
               $scope.total_ideas  = data.total_ideas
               console.log $scope.total_ideas
               goTop()
    )

  getIdeas()

  $scope.new_idea = {}
  $("#idea_search").keyup( ()->
    Idea.search({q:$scope.new_idea.title},(data) ->
      $scope.ideas        = data.ideas
      $scope.total_ideas  = data.total_ideas
    )
  )

  $scope.$watch("page",()->
    getIdeas()
  )

  $scope.next = ()->
    if $scope.page < $scope.total_ideas/$scope.per_page
      $scope.page += 1

  $scope.previous = ()->
    if $scope.page > 1
      $scope.page -= 1

  $scope.addIdea = ->

    Idea.save $scope.new_idea, ()->
      getIdeas()

    $scope.new_idea.title = ""
    $scope.new_idea.description = ""

]

