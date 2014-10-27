#= require spec_helper

describe 'UserProfileCtrl', ->
  beforeEach ->
    @controller('TasksController', { $scope: @scope })
    @UserProfile = @model('UserProfile')
    @user_profile = [new @UserProfile({ id: 1, name: 'A Users real name' })]

    @http.whenGET('/user_profiles/12345').respond(200, @user_profile)
    @http.flush()



