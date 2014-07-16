class MapService
  @$inject: ['$q', '$http']
  @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
  @defaultConfig = { headers: @headers }

  constructor: (@q, @http, @rootScope) ->
    console.log 'Constructing MapService'

  getMarker: () ->
    deferred = @q.defer()

    @http.get("/ping_pong_tables.json")
    .success((data, status, headers) =>
      console.log("Successfully listed PingPongTables - status #{status}")
      deferred.resolve(data)
    )
    .error((data, status, headers) =>
      console.log("Successfully listed PingPongTables - status  - status #{status}")
      deferred.reject(data);
    )
    deferred.promise

servicesModule.service 'MapService', MapService, ['$q', '$http']

