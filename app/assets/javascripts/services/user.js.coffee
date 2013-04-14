window.OpinioDev.factory "User", ["railsResourceFactory", (railsResourceFactory) ->
  resource = railsResourceFactory
    url: "/users"
    name: "user"
  resource
]

