(function (app) {
    'use strict';

    app.controller('movieEditCtrl', movieEditCtrl);

    movieEditCtrl.$inject = ['$scope', 'FileUploader', '$location', '$routeParams', 'apiService', 'notificationService', '$rootScope'];

    function movieEditCtrl($scope, FileUploader, $location, $routeParams, apiService, notificationService, $rootScope) {
        /*Initial variable*/
        $scope.pageClass = 'page-movies';
        $scope.movie = {};
        $scope.genres = [];
        $scope.loadingMovie = true;
        $scope.isReadOnly = false;
        $scope.UpdateMovie = UpdateMovie;
        //$scope.prepareFiles = prepareFiles;
        $scope.openDatePicker = openDatePicker;

        $scope.dateOptions = {
            formatYear: 'yy',
            startingDay: 1
        };
        $scope.datepicker = {};
        /*Initial variable*/

        /*Automatic Upload Image*/
        var uploader = $scope.uploader = new FileUploader({
            url: '/api/movies/images/upload?movieId=' + +$routeParams.id
        });
        uploader.headers["Authorization"] = $rootScope.repository.loggedUser.authdata;
        uploader.filters.push({
            name: 'imageFilter',
            fn: function (item /*{File|FileLikeObject}*/, options) {
                var filename = item.name;
                var extension = filename.substring(filename.lastIndexOf('.') + 1).toLowerCase();
                if (extension == "jpg" || extension == "png" || extension == "jpeg" || extension == "bmp" || extension == "gif")
                    return true;
                else {
                    notificationService.displayError('Invalid file format. Please select a file with pdf/doc/docs or rtf format  and try again.');
                    return false;
                }
                //var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
                //return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
            }
        });
        uploader.onWhenAddingFileFailed = function (item, filter, options) {
            console.info('onWhenAddingFileFailed', item, filter, options);
        };
        uploader.onAfterAddingFile = function (fileItem) {
            $scope.uploader.uploadAll();
            //alert('Files ready for upload.');
        };

        uploader.onSuccessItem = function (fileItem, response, status, headers) {
            $scope.uploader.queue = [];
            $scope.uploader.progress = 0;
            $scope.movie.Image = response.FileName;
            notificationService.displaySuccess('Selected file has been uploaded successfully.');
        };
        uploader.onErrorItem = function (fileItem, response, status, headers) {
            notificationService.displayError('We were unable to upload your file. Please try again.');
        };
        uploader.onCancelItem = function (fileItem, response, status, headers) {
            $scope.uploader.queue = [];
            notificationService.displayError('File uploading has been cancelled.');
        };

        uploader.onAfterAddingAll = function (addedFileItems) {
            console.info('onAfterAddingAll', addedFileItems);
        };
        uploader.onBeforeUploadItem = function (item) {
            console.info('onBeforeUploadItem', item);
        };
        uploader.onProgressItem = function (fileItem, progress) {
            console.info('onProgressItem', fileItem, progress);
        };
        uploader.onProgressAll = function (progress) {
            console.info('onProgressAll', progress);
        };

        uploader.onCompleteItem = function (fileItem, response, status, headers) {
            console.info('onCompleteItem', fileItem, response, status, headers);
        };
        uploader.onCompleteAll = function () {
            console.info('onCompleteAll');
        };
        /*Automatic Upload Image*/

        function loadMovie() {
            $scope.loadingMovie = true;

            apiService.get('/api/movies/details/' + $routeParams.id, null,
            movieLoadCompleted,
            movieLoadFailed);
        }

        function movieLoadCompleted(result) {
            $scope.movie = result.data;
            $scope.loadingMovie = false;
            loadGenres();
        }

        function movieLoadFailed(response) {
            notificationService.displayError(response.data);
        }

        function loadGenres() {
            apiService.get('/api/genres/all', null,
            genresLoadCompleted,
            genresLoadFailed);
        }

        function genresLoadCompleted(response) {
            $scope.genres = response.data;
        }

        function genresLoadFailed(response) {
            notificationService.displayError(response.data);
        }

        function UpdateMovie() {
            UpdateMovieModel();
        }

        function UpdateMovieModel() {
            apiService.post('/api/movies/update', $scope.movie,
            updateMovieSucceded,
            updateMovieFailed);
        }

        function updateMovieSucceded(response) {
            console.log(response);
            notificationService.displaySuccess($scope.movie.Title + ' has been updated');
            $scope.movie = response.data;
            movieImage = null;
        }

        function updateMovieFailed(response) {
            notificationService.displayError(response);
        }

        function openDatePicker($event) {
            $event.preventDefault();
            $event.stopPropagation();

            $scope.datepicker.opened = true;
        };

        loadMovie();
    }
})(angular.module('VinhCinema'));