window.OpinioDev.factory "Idea", ($resource) ->
  Idea = $resource('/ideas/:id/:action', {id:'@id'},
                    update:
                      method: 'PUT'
                    total_ideas:
                        method: 'GET'
                        params:
                          action: "total_ideas"
                        isArray: false
                  )

  Idea::total_ideas = (cb) ->
    console.log cb
    cb

  Idea::update = (cb) ->
    Idea.update
      id: @_id.$oid
    , angular.extend({}, this,
                     _id: `undefined`
    ), cb

  Idea::destroy = (cb) ->
    Idea.remove
      id: @_id.$oid
    , cb

  Idea
