window.OpinioDev.controller 'searchCtrl',["$scope","$http","Idea", ($scope,$http,Idea) ->
  #init variables
  $scope.page        = 1
  $scope.per_page    = 3
  $scope.total_ideas = $scope.page*$scope.per_page
  $scope.current_user= {name: "Anonymous",email:"anonymous@email.com"}

  goTop = ->
    $("html, body").animate({ scrollTop: 0 }, "slow")

  getIdeas = ()->
    params = {page:$scope.page,per_page:$scope.per_page}
    if $('#idea_search').val() != ''
      params.q = $('#idea_search').val()

    Idea.query(params).then((data)->
                  $scope.ideas        = data[0].ideas
                  $scope.total_ideas  = data[0].totalIdeas
                  goTop()
    )

  $scope.$watch("page",()->
    getIdeas()
  )

  $scope.new_idea = {}
  $("#idea_search").keyup( ()->
    #we make a check here to see if the page is bigger than 1 so that we don't make 2 requests
    if $scope.page>1
      $scope.page = 1
    else
      getIdeas()
  )

  $scope.next = ()->
    if $scope.page < $scope.total_ideas/$scope.per_page
      $scope.page += 1

  $scope.previous = ()->
    if $scope.page > 1
      $scope.page -= 1

  $scope.like = (idea)->
    idea.votes += 1
    new Idea({id:idea._id,votes:idea.votes}).update()

  $scope.dislike = (idea)->
    if idea.votes>0
      idea.votes -= 1
      new Idea({id:idea._id,votes:idea.votes}).update()

  $scope.addIdea = ->
    new Idea($scope.new_idea).create().then((result)->
      getIdeas()
    )

    $scope.new_idea.title = ""
    $scope.new_idea.description = ""

]

