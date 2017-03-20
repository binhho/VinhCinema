﻿(function() {
    'use strict';

    angular
        .module('common.core')
        .factory('membershipService', membershipService);

    membershipService.$inject = ['apiService', 'notificationService','$http', '$base64', '$cookieStore', '$rootScope'];
    function membershipService(apiService, notificationService, $http, $base64, $cookieStore, $rootScope) {
        var service = {
            login: login,
            register: register,
            saveCredentials: saveCredentials,
            removeCredentials: removeCredentials,
            isUserLoggedIn: isUserLoggedIn  
        };
        
        return service;

        ////////////////
        function login(user, completed) { 
            apiService.post('/api/account/authenticate', user, completed, loginFailed)
        }

        function register(user, completed){
            apiService.post('/api/account/register', user, completed, registrationFailed)
        }

        function saveCredentials(user) {
            var membershipData = $base64.encode(user.username + ":" + user.password);
            $rootScope.repository = {
                loggedUser: {
                    username: user.username,
                    authdata: membershipData
                }
            };
            $http.defaults.headers.common['Authorization'] = 'Basic ' + membershipData;
            $cookieStore.put('repository', $rootScope.repository);   
        }

        

        function removeCredentials() {
            $rootScope.repository = {};
            $cookieStore.remove('repository');
            $http.defaults.headers.common.Authorization = '';
        }

        function isUserLoggedIn(){
            return $rootScope.repository.loggedUser != null;
        }

        function loginFailed(response){
            notificationService.displayError(response.data);                
        }

        function registrationFailed(response){
            notificationService.displayError("registration failed. Try again.");
        }
    }
})();