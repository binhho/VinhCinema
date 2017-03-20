(function (app) {
    'use strict';

    app.controller('indexCtrl', indexCtrl);

    indexCtrl.$inject = ['$scope', 'apiService', 'notificationService', '$rootScope'];

    function indexCtrl($scope, apiService, notificationService, $rootScope) {
        $scope.pageClass = 'page-home';
        $scope.loadingMovies = true;
        $scope.loadingGenres = true;
        $scope.isReadOnly = true;

        $scope.latestMovies = [];
        $scope.loadData = loadData;

        $rootScope.Flag = 0;
        $rootScope.Previous = 0;

        function loadData() {
            apiService.get('/api/movies/all', null,
                        moviesLoadCompleted,
                        moviesLoadFailed);

            apiService.get("/api/genres/all", null,
                genresLoadCompleted,
                genresLoadFailed);
        }

        function moviesLoadCompleted(result)
        {
            $scope.latestMovies = result.data;
            $scope.loadingMovies = false;
        }

        function moviesLoadFailed(response) {
            notificationService.displayError(response.data.Message);
        }

        function genresLoadCompleted(result)
        {
            var genres = result.data;
            Morris.Bar({
                element: "genres-bar",
                data: genres,
                xkey: "Name",
                ykeys: ["NumberOfMovies"],
                labels: ["Number Of Movies"],
                barRatio: 0.4,
                xLabelAngle: 55,
                hideHover: "auto",
                resize: 'true'
            });
            $scope.loadingGenres = false;
        }

        function genresLoadFailed()
        {
            notificationService.displayError(response.data.Message);
        }

        loadData();
    }

})(angular.module('VinhCinema'));