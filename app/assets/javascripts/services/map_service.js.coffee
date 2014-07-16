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
      deferred.resolve(data)
    )
    .error((data, status, headers) =>
      deferred.reject(data);
    )
    deferred.promise

servicesModule.service 'MapService', MapService, ['$q', '$http']

