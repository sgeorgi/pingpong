class MapService
  @$inject: ['$q', '$http']
  @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
  @defaultConfig = { headers: @headers }

  constructor: (@q, @http) ->
    console.log 'Constructing MapService'

  getTables: (_center, _edge) ->
    deferred = @q.defer()

    @http.get("/ping_pong_tables.json?c=" + _center + "&e=" + _edge)
    .success((data, status, headers) =>
      deferred.resolve(data)
    )
    .error((data, status, headers) =>
      deferred.reject(data);
    )
    deferred.promise

servicesModule.service 'MapService', MapService, ['$q', '$http']

