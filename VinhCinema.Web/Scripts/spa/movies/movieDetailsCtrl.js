(function (app) {
    'use strict';

    app.controller('movieDetailsCtrl', movieDetailsCtrl);

    movieDetailsCtrl.$inject = ['$scope', '$location', '$routeParams', '$modal', 'apiService', 'notificationService', '$route', '$rootScope'];

    function movieDetailsCtrl($scope, $location, $routeParams, $modal, apiService, notificationService, $route, $rootScope) {
        $scope.pageClass = 'page-movies';
        $scope.movie = {};
        $scope.loadingMovie = true;
        $scope.loadingRentals = true;
        $scope.isReadOnly = true;
        $scope.openRentDialog = openRentDialog;
        $scope.returnMovie = returnMovie;
        $scope.rentalHistory = [];
        $scope.getStatusColor = getStatusColor;
        $scope.clearSearch = clearSearch;
        $scope.isBorrowed = isBorrowed;

        $scope.$on('$routeChangeStart', function (event, next, current) {
            if (next.$$route.controller == "moviesCtrl") {
                // Show here for your model, and do what you need**
                $rootScope.Flag = 1;
            }
        });

        function loadMovie() {
            $scope.loadingMovie = true;
            $rootScope.Previous = parseInt($routeParams.cpage);
            apiService.get('/api/movies/details/' + $routeParams.id, null,
            movieLoadCompleted,
            movieLoadFailed);
        }

        function loadRentalHistory() {
            $scope.loadingRentals = true;

            apiService.get('/api/rentals/rentalhistory/' + $routeParams.id, null,
            rentalHistoryLoadCompleted,
            rentalHistoryLoadFailed);
        }

        function loadMovieDetails() {
            loadMovie();
            loadRentalHistory();
        }

        function returnMovie(rentalID) {
            apiService.post('/api/rentals/return/' + rentalID, null,
            returnMovieSucceeded,
            returnMovieFailed);
        }

        function isBorrowed(rental) {
            return rental.Status == 'Borrowed';
        }

        function getStatusColor(status) {
            if (status == 'Borrowed')
                return 'red'
            else {
                return 'green';
            }
        }

        function clearSearch() {
            $scope.filterRentals = '';
        }

        function movieLoadCompleted(result) {
            $scope.movie = result.data;
            $scope.loadingMovie = false;
        }

        function movieLoadFailed(response) {
            notificationService.displayError(response.data);
        }

        function rentalHistoryLoadCompleted(result) {
            console.log(result);
            $scope.rentalHistory = result.data;
            $scope.loadingRentals = false;
        }

        function rentalHistoryLoadFailed(response) {
            notificationService.displayError(response);
        }

        function returnMovieSucceeded(response) {
            notificationService.displaySuccess('Movie returned to HomeCinema succeesfully');
            loadMovieDetails();
        }

        function returnMovieFailed(response) {
            notificationService.displayError(response.data);
        }

        function openRentDialog() {
            $modal.open({
                templateUrl: 'scripts/spa/rental/rentMovie.html',
                controller: 'rentMovieCtrl',
                scope: $scope
            }).result.then(function ($scope) {
                loadMovieDetails();
            }, function () {
            });
        }

        loadMovieDetails();
    }
})(angular.module('VinhCinema'));