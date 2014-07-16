dependencies = [
  'ngResource',
  'pingpong.services',
  'pingpong.controllers'
]

@app = angular.module('pingpong', dependencies)

@app.config ['$httpProvider', ($httpProvider) ->
            $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

@controllersModule = angular.module('pingpong.controllers', [])
@servicesModule = angular.module('pingpong.services', [])