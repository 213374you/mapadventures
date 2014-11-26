
class UserService

    @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
    @defaultConfig = { headers: @headers }

    constructor: (@$log, @$http, @$q) ->
        @$log.debug "constructing UserService"

        #initilize map ad set position with zoom
        map = L.map("map").setView([
          27.8700214
          -82.6319962
        ], 11)

        # This is the API key taken from MAPBOX. Currently the wamba account is being utilized.
        L.tileLayer("https://{s}.tiles.mapbox.com/v3/wamba100.kal9ikgm/{z}/{x}/{y}.png",
          attribution: "Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"http://mapbox.com\">Mapbox</a>"
          maxZoom: 18
        ).addTo map

    listUsers: () ->
        @$log.debug "listUsers()"
        deferred = @$q.defer()

        @$http.get("/users")
        .success((data, status, headers) =>
                @$log.info("Successfully listed Users - status #{status}")
                deferred.resolve(data)
            )
        .error((data, status, headers) =>
                @$log.error("Failed to list Users - status #{status}")
                deferred.reject(data);
            )
        deferred.promise

    createUser: (user) ->
        @$log.debug "createUser #{angular.toJson(user, true)}"
        deferred = @$q.defer()



        @$http.post('/user', user)
        .success((data, status, headers) =>
                @$log.info("Successfully created User - status #{status}")
                deferred.resolve(data)
            )
        .error((data, status, headers) =>
                @$log.error("Failed to create user - status #{status}")
                deferred.reject(data);
            )
        deferred.promise

servicesModule.service('UserService', UserService)