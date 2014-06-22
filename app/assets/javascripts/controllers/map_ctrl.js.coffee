class MapCtrl
  @$inject: ['$q', '$http', '$scope']

  constructor: (@q, @http, @scope) ->
    @scope.map = { center: { latitude: 53.5779706, longitude: 10.0027104 }, zoom: 13 }

app = angular.module('pingpong')
app.controller 'MapCtrl', MapCtrl