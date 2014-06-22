class MapCtrl
  @$inject: ['$q', '$http', '$scope']

  constructor: (@q, @http, @scope) ->
    @initializeMap()

  initializeMap: ->
    map = @scope.map
    map = L.map('map').setView([53.5779706, 10.0027104], 13)
    L.tileLayer('http://{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright" title="OpenStreetMap" target="_blank">OpenStreetMap</a> contributors | Tiles Courtesy of <a href="http://www.mapquest.com/" title="MapQuest" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png" width="16" height="16">',
      subdomains: ['otile1', 'otile2', 'otile3', 'otile4']
    }).addTo(map)

    L.marker([53.5779706, 10.0027104]).addTo(map);

app = angular.module('pingpong')
app.controller 'MapCtrl', MapCtrl