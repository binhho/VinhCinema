(function() {
    'use strict';

    angular
        .module('common.ui')
        .directive('availableMovie', availableMovie);

    function availableMovie() {
        var directive = {
            link: link,
            restrict: 'E',
            templateUrl: "/Scripts/spa/directives/availableMovie.html"
        };
        return directive;
        
        function link($scope, $element, $attrs) {
            $scope.getAvailableClass = function () {
                if ($attrs.IsAvailable === 'true') {
                    return 'label label-success'
                } else {
                    return 'label label-danger'
                }
            };
            $scope.getAvailability = function () {
                if ($attrs.IsAvailable === 'true') {
                    return 'Available'
                } else {
                    return 'Not Available'
                }
            }
        }
    }
})();