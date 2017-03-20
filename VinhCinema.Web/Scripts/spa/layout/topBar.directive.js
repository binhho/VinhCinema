(function() {
    'use strict';

    angular.module('common.ui').directive('topBar', topBar);
    function topBar() {
        var directive = {
            restrict: 'E',
            replace: true,
            templateUrl:'/Scripts/spa/layout/topBar.html'
        };
        return directive;
    }
})();