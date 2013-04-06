window.OpinioDev = angular.module "OpinioDev", ["ngResource"]

window.OpinioDev.directive "noHref", ->
  (scope, element, attrs) ->
    $(element).click (event) ->
      event.preventDefault()
