class MapCtrl
  @$inject: ['$scope', 'MapService']

  constructor: (@scope, @map_service) ->
    console.log "Constructing MapCtrl"
    @activeMarkers = []

    @map = @initializeMap()
    @updateMarkers()

    marker = L.marker([53.5779706, 10.0027104])
    marker.addTo(@map)
    @map.removeLayer(marker)

  updateMarkers: () ->
    @map_service.getMarker()
    .then(
      (data) =>
        console.log "Promise returned #{data.length} Markers"
        @map.removeLayer(marker) for marker in @activeMarkers
        @activeMarkers = (L.marker([table.latitude, table.longitude]) for table in data)
        marker.addTo(@map) for marker in @activeMarkers
        @activeBounds = @map.getBounds()
    ,
    (error) =>
      console.log "Unable to get Markers: #{error}"
    )


  initializeMap: () ->
    map = L.map('map').setView([53.5779706, 10.0027104], 13)
    L.tileLayer('http://{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright" title="OpenStreetMap" target="_blank">OpenStreetMap</a> contributors | Tiles Courtesy of <a href="http://www.mapquest.com/" title="MapQuest" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png" width="16" height="16">',
      subdomains: ['otile1', 'otile2', 'otile3', 'otile4']
    }).addTo(map)
    map


controllersModule.controller 'MapCtrl', MapCtrl, ['$scope', 'MapService']
