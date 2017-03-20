(function (app) {
    'use strict';

    app.controller('customersRegCtrl', customersRegCtrl);

    customersRegCtrl.$inject = ['$scope', '$location', '$timeout', '$rootScope', 'apiService', 'notificationService'];

    function customersRegCtrl($scope, $location, $timeout, $rootScope, apiService, notificationService) {
        $scope.newCustomer = {};
        $scope.Register = Register;

        $scope.openDatePicker = openDatePicker;
        $scope.dateOptions = {
            formatYear: 'yy',
            startingDay: 1
        };
        $scope.datepicker = {};

        $scope.submission = {
            successMessages: ['Successfull submission will appear here.'],
            errorMessages: ['Submition errors will appear here.']
        };
        function Register()
        {
            apiService.post('/api/customers/register'
                , $scope.newCustomer
                , registerCustomerSucceded
                , registerCustomerFailed);
        }

        function registerCustomerSucceded(response)
        {
            console.log(response);
            var customerRegistered = response.data;
            notificationService.displaySuccess($scope.newCustomer.LastName + $scope.newCustomer.FirstName + ' has been successfully registed');
            notificationService.displaySuccess('Check ' + customerRegistered.UniqueKey + ' for reference number');
            $scope.newCustomer = {};
        }

        function registerCustomerFailed(response)
        {
            console.log(response);
            if (response.status == '400')
                notificationService.displayError(response.data);
            else
                notificationService.displayError(response.statusText);
        }

        function openDatePicker($event)
        {
            $event.preventDefault();
            $event.stopPropagation();

            //$scope.datepicker.opened = true;
            $timeout(function () {
                $scope.datepicker.opened = true;
            });

            $timeout(function () {
                $('ul[datepicker-popup-wrap]').css('z-index', '10000');
            }, 100);
        }
    }
})(angular.module('VinhCinema'));