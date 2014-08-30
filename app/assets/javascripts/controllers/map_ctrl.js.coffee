class MapCtrl
  @$inject: ['$q', '$scope', 'MapService']

  constructor: (@q, @scope, @map_service) ->
    console.log "Constructing MapCtrl"
    @activeMarkers = []
    @map = @initializeMap()
    @updateMap()

  updateMap: () ->
    center = @map.getCenter()
    northEast = @map.getBounds()._northEast
    @map_service.getTables([center.lat, center.lng], [northEast.lat, northEast.lng])
    .then((data) =>
      @processTables(data)
    ,
    (error) =>
      console.log "Unable to get Markers: #{error}"
    )

  processTables: (_tables) ->
    console.log "Processing Tables"
    @activeTables = _tables
    @updateMarkers()

  updateMarkers: ->
    @clearMarkers()
    @addMarkers((L.marker([table.latitude, table.longitude]) for table in @activeTables))

  clearMarkers: ->
    @map.removeLayer(marker) for marker in @activeMarkers
    @activeMarkers = []
    console.log "clearMarkers: " + @activeMarkers.length

  addMarkers: (markers) ->
    marker.addTo(@map) for marker in markers
    @activeMarkers = markers
    console.log "addMarkers: " + @activeMarkers.length

  initializeMap: () ->
    map = L.map('map').setView([53.5779706, 10.0027104], 13)
    L.tileLayer('http://{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright" title="OpenStreetMap" target="_blank">OpenStreetMap</a> contributors | Tiles Courtesy of <a href="http://www.mapquest.com/" title="MapQuest" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png" width="16" height="16">',
      subdomains: ['otile1', 'otile2', 'otile3', 'otile4']
    }).addTo(map)

    map.on("load moveend", (e) =>
       @updateMap()
    )
    map


controllersModule.controller 'MapCtrl', MapCtrl, ['$q', '$scope', 'MapService']
