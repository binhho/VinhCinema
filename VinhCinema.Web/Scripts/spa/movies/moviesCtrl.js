(function (app) {
    'use strict';
    app.controller('moviesCtrl', moviesCtrl);
    moviesCtrl.$inject = ['$scope', '$modal', 'apiService', 'notificationService', '$route', '$rootScope'];
    function moviesCtrl($scope, $modal, apiService, notificationService, $route, $rootScope) {
        $scope.pageClass = 'page-movies';
        $scope.loadingMovies = true;
        $scope.page = 0;
        $scope.pagesCount = 0;
        $scope.Movies = [];
        
        $scope.search = search;
        $scope.clearSearch = clearSearch;


        //$scope.$on('$routeChangeStart', function (event, next, current) {
        //    if (next.$$route.controller == "movieDetailsCtrl") {
        //        // Show here for your model, and do what you need**
        //        $rootScope.PreviousPage = $rootScope.CurrentPage;
        //        alert('Test');
        //    }
        //});

        function search(page) {
            page = page || 0;
            //$scope.Pagination.CurrentPage = page;

            $scope.loadingMovies = true;
            if ($rootScope.Flag == 1) {
                var config = {
                    params: {
                        page: $rootScope.Previous,
                        pageSize: 6,
                        filter: $scope.filterMovies
                    }
                };
            } else {
                var config = {
                    params: {
                        page: page,
                        pageSize: 6,
                        filter: $scope.filterMovies
                    }
                };
            }
            
            apiService.get('/api/movies/search/', config,
            moviesLoadCompleted,
            moviesLoadFailed);
        }

        function moviesLoadCompleted(result) {
            $scope.Movies = result.data.Items;
            $scope.page = result.data.Page;
            $scope.pagesCount = result.data.TotalPages;
            $scope.totalCount = result.data.TotalCount;
            $scope.loadingMovies = false;
            $rootScope.Flag = 0;
            if ($scope.filterMovies && $scope.filterMovies.length) {
                notificationService.displayInfo(result.data.Items.length + ' movies found');
            }
            
        }

        function moviesLoadFailed(response) {
            notificationService.displayError(response.data);
        }

        function clearSearch() {
            $scope.filterMovies = '';
            search();
        }

        

        $scope.search();
    }
})(angular.module('VinhCinema'));