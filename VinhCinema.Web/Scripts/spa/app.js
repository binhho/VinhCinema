(function () {
    'use strict';
    angular.module('VinhCinema', ['common.core', 'common.ui'])
        .config(configFunction)
        .run(run);
    configFunction.$inject = ["$routeProvider"];
    function configFunction($routeProvider) {
        $routeProvider
            .when("/", {
                templateUrl: "scripts/spa/home/index.html",
                controller: "indexCtrl"
            })
            .when("/login", {
                templateUrl: "scripts/spa/account/login.html",
                controller: "loginCtrl"
            })
            .when("/register", {
                templateUrl: "scripts/spa/account/register.html",
                controller: "registerCtrl"
            })
            .when("/customers", {
                templateUrl: "scripts/spa/customers/customers.html",
                controller: "customersCtrl"
            })
            .when("/customers/register", {
                templateUrl: "scripts/spa/customers/CustomersReg.html",
                controller: "customersRegCtrl",
                resolve: { isAuthenticated: isAuthenticated }
            })
            .when("/userInfo", {
                templateUrl: "scripts/spa/user/User.html",
                controller: "UserCtrl",
                resolve: { isAuthenticated: isAuthenticated }
            })
            .when("/movies", {
                templateUrl: "scripts/spa/movies/movies.html",
                controller: "moviesCtrl"
            })
            .when("/movies/add", {
                templateUrl: "scripts/spa/movies/movieAdd.html",
                controller: "movieAddCtrl",
                resolve: { isAuthenticated: isAuthenticated }
            })
            .when("/movies/:id/currentPage/:cpage", {
                templateUrl: "scripts/spa/movies/movieDetails.html",
                controller: "movieDetailsCtrl"
            })
            .when("/movies/edit/:id", {
                templateUrl: "scripts/spa/movies/movieEdit.html",
                controller: "movieEditCtrl"
            })
            .when("/rental", {
                templateUrl: "scripts/spa/rental/Rental.html",
                controller: "RentalCtrl",
                resolve: { isAuthenticated: isAuthenticated }
            }).otherwise({ redirectTo: "/" });
    }

    run.$inject = ['$rootScope', '$location', '$cookieStore', '$http'];
    function run($rootScope, $location, $cookieStore, $http)
    {
        $rootScope.repository = $cookieStore.get('repository') || {};
        if ($rootScope.repository.loggedUser) {
            $http.defaults.headers.common['Authorization'] = $rootScope.repository.loggedUser.authdata;
        }

        $(document).ready(function () {
            $(".fancybox").fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });

            $('.fancybox-media').fancybox({
                openEffect: 'none',
                closeEffect: 'none',
                helpers: {
                    media: {}
                }
            });

            $('[data-toggle=offcanvas]').click(function () {
                $('.row-offcanvas').toggleClass('active');
            });
        });
    }

    isAuthenticated.$inject = ['membershipService', '$rootScope', '$location', 'notificationService'];

    function isAuthenticated(membershipService, $rootScope, $location, notificationService) {
        if (!membershipService.isUserLoggedIn()) {
            if ($location.path() != '/login') {
                $rootScope.previousState = $location.path();
            }
            $location.path('/login');
            notificationService.displayError("Authentication required");
        }
    }
})();