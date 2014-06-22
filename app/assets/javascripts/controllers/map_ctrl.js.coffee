class MapCtrl
  @$inject: ['$q', '$http', '$scope']

  constructor: (@q, @http, @scope) ->
    @scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 }

app = angular.module('pingpong')
app.controller 'MapCtrl', MapCtrl