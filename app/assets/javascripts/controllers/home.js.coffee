window.OpinioDev.controller 'searchCtrl',["$scope","$rootScope","$http","Idea", ($scope,$rootScope,$http,Idea) ->
  #init variables
  $scope.page        = 1
  $scope.per_page    = 3
  $scope.total_ideas = $scope.page*$scope.per_page
  $scope.new_idea = {}

  goTop = ->
    $("html, body").animate({ scrollTop: 0 }, "slow")

  $scope.$on("gotUser",()->
    $scope.new_idea.user_id = $rootScope.user._id
  )

  getIdeas = ()->
    params = {page:$scope.page,per_page:$scope.per_page}
    if $scope.new_idea.title
      params.q = $scope.new_idea.title

    Idea.query(params).then((data)->
                  $scope.ideas        = data[0].ideas
                  $scope.total_ideas  = data[0].totalIdeas
                  goTop()
    )

  $scope.$watch("page",()->
    getIdeas()
  )

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
    # allowing negative votes
    #if idea.votes>0
      idea.votes -= 1
      new Idea({id:idea._id,votes:idea.votes}).update()

  $scope.reset = ->
    $scope.new_idea = angular.copy({title:"",description:""})

  $scope.isUnchanged = (new_idea) ->
    angular.equals new_idea, {title:"",description:""}

  $scope.addIdea = ->
    new Idea($scope.new_idea).create().then((result)->
      if !result.success
        console.log "fara success"
        $("#alert").html(result.info[0].error).show(300)
      else
        $scope.reset()
        console.log "cu success"
        getIdeas()
    )
]

