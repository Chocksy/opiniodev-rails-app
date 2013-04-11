window.OpinioDev = angular.module "OpinioDev", ["rails"]

window.OpinioDev.directive "noHref", ->
  (scope, element, attrs) ->
    $(element).click (event) ->
      event.preventDefault()
