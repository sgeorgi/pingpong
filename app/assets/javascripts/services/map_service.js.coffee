angular.module('pingpong').service 'MapService', ['$q', '$http', '$rootScope', ($q, $http, $rootScope)->
  class MapService
#    @$inject: ['$q', '$http', '$rootScope']
    @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
    @defaultConfig = { headers: @headers }

    constructor: (@q, @http, @rootScope) ->
      console.log 'Constructing MapService'

    getMarker: () ->
      [53.5779706, 10.0027104]

  new MapService($q, $http, $rootScope)
]
