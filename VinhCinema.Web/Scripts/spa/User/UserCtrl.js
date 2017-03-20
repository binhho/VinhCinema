(function (app) {
    'use strict';

    app.controller('UserCtrl', UserCtrl);

    UserCtrl.$inject = ['$scope', 'apiService', 'notificationService'];

    function UserCtrl($scope, apiService, notificationService) {
       
    }

})(angular.module('VinhCinema'));