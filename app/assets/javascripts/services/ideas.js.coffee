window.OpinioDev.factory "Idea", ["railsResourceFactory", (railsResourceFactory) ->
  resource = railsResourceFactory
    url: (context)->
      if context.vote
        "/ideas/"+context.vote+"/"+context.id
      else
        if context.id
          context.id
        else
          "ideas/"

    name: "idea"
  resource
]

