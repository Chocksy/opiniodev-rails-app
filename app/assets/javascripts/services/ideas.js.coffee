window.OpinioDev.factory "Idea", ["$resource",($resource) ->
  Idea = $resource('/ideas/:id/:action', {id:'@id'},
                    update:
                      method: 'PUT'
                    search:
                      method: "GET"
                      params:
                        action: "search"
                      isArray: false
                    query:
                      method: 'GET'
                      isArray: false
                  )

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
]