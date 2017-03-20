(function (app) {
    'use strict';

    app.controller('movieAddCtrl', movieAddCtrl);

    movieAddCtrl.$inject = ['$scope', 'FileUploader', '$location', '$routeParams', 'apiService', 'notificationService', '$rootScope'];

    function movieAddCtrl($scope, FileUploader, $location, $routeParams, apiService, notificationService, $rootScope) {
        /*Initial variable*/
        $scope.pageClass = 'page-movies';
        $scope.movie = { GenreId: 1, Rating: 1, NumberOfStocks: 1 };

        $scope.genres = [];
        $scope.isReadOnly = false;
        $scope.AddMovie = AddMovie;
        $scope.openDatePicker = openDatePicker;
        $scope.changeNumberOfStocks = changeNumberOfStocks;

        $scope.dateOptions = {
            formatYear: 'yy',
            startingDay: 1
        };
        $scope.datepicker = {};
        var movieImage = null;
        /*Initial variable*/

        /*Automatic Upload Image*/
        var uploader = $scope.uploader = new FileUploader({
            url: '/api/upload/AddUpload'
        });
        uploader.headers["Authorization"] = $rootScope.repository.loggedUser.authdata;
        //uploader.headers["Content-Type"] = 'application/json';
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
            //$scope.uploader.uploadAll();
            alert('Files ready for upload.');
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


        function AddMovie()
        {
            apiService.post('/api/movies/add', $scope.movie,
            addMovieSucceded,
            addMovieFailed);
        }

        function addMovieSucceded(response)
        {
            notificationService.displaySuccess($scope.movie.Title + ' has been submitted to Home Cinema');
            $scope.movie = response.data;
            redirectToEdit();

        }

        function addMovieFailed(response) {
            console.log(response);
            notificationService.displayError(response.statusText);
        }

        function redirectToEdit() {
            $location.url('movies');
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

        function openDatePicker($event) {
            $event.preventDefault();
            $event.stopPropagation();

            $scope.datepicker.opened = true;
        };

        function changeNumberOfStocks($vent)
        {
            var btn = $('#btnSetStocks'),
            oldValue = $('#inputStocks').val().trim(),
            newVal = 0;

            if (btn.attr('data-dir') == 'up') {
                newVal = parseInt(oldValue) + 1;
            } else {
                if (oldValue > 1) {
                    newVal = parseInt(oldValue) - 1;
                } else {
                    newVal = 1;
                }
            }
            $('#inputStocks').val(newVal);
            $scope.movie.NumberOfStocks = newVal;
            console.log($scope.movie);
        }

        loadGenres();
    }
})(angular.module('VinhCinema'));