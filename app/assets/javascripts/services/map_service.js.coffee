class MapService
  @$inject: ['$q', '$http']
  @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
  @defaultConfig = { headers: @headers }

  constructor: (@q, @http, @rootScope) ->
    console.log 'Constructing MapService'

  getMarker: () ->
    [53.5779706, 10.0027104]

servicesModule.service 'MapService', MapService, ['$q', '$http']

