using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using VinhCinema.Data.Extensions;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;
using VinhCinema.Web.Infrastructure.Core;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Controllers
{
    [Authorize(Roles = "Admin")]
    [RoutePrefix("api/rentals")]
    public class RentalsController : ApiControllerBaseExtended
    {
        public RentalsController(IDataRepositoryFactory dataRepositoryFactory, IUnitOfWork unitOfWork)
            : base(dataRepositoryFactory, unitOfWork) { }

        [HttpPost]
        [Route("rent/{customerId:int}/{stockId:int}")]
        public IHttpActionResult Rent(HttpRequestMessage request, int customerId, int stockId)
        {
            _requiredRepositories = new List<Type>() { typeof(Customer), typeof(Stock), typeof(Rental) };

            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                var customer = _customersRepository.GetSingle(customerId);
                var stock = _stocksRepository.GetSingle(stockId);
                if (customer == null || stock == null)
                {
                    response = request.CreateErrorResponse(HttpStatusCode.NotFound, "Invalid Customer or Stock");
                }
                else
                {
                    if (stock.IsAvailable)
                    {
                        Rental _rental = new Rental()
                        {
                            CustomerID = customerId,
                            StockID = stockId,
                            RentalDate = DateTime.Now,
                            Status = "Borrowed"
                        };
                        _rentalsRepository.Add(_rental);
                        stock.IsAvailable = false;

                        _unitOfWork.Commit();

                        RentalViewModel rentalVm = Mapper.Map<Rental, RentalViewModel>(_rental);

                        response = request.CreateResponse(HttpStatusCode.Created, rentalVm);

                    }
                    else
                    {
                        response = request.CreateErrorResponse(HttpStatusCode.BadRequest, "Selected stock is not available anymore");
                    }
                }
                return response;
            });
        }

        [HttpGet]
        [Route("rentalhistory/{id:int}")]
        public IHttpActionResult RentalHistory(HttpRequestMessage request, int id)
        {
            _requiredRepositories = new List<Type>() { typeof(Customer), typeof(Stock), typeof(Rental), typeof(Movie) };
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                List<RentalHistoryViewModel> _rentalHistory = GetMovieRentalHistory(id);
                response = request.CreateResponse(HttpStatusCode.OK, _rentalHistory);
                return response;
            });
        }

        [HttpPost]
        [Route("return/{rentalId:int}")]
        public IHttpActionResult Return(HttpRequestMessage request, int rentalId)
        {
            _requiredRepositories = new List<Type>() { typeof(Rental) };
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                var rental = _rentalsRepository.GetSingle(rentalId);
                if (rental == null)
                {
                    response = request.CreateResponse(HttpStatusCode.NotFound, "Invalid rental");
                }
                else
                {
                    rental.Status = "Returned";
                    rental.Stock.IsAvailable = true;
                    rental.ReturnedDate = DateTime.Now;
                    _unitOfWork.Commit();
                    response = request.CreateResponse(HttpStatusCode.OK);
                }
                return response;
            });
        }

        [HttpGet]
        [Route("rentalhistory")]
        public IHttpActionResult TotalRentalHistory(HttpRequestMessage request)
        {
            _requiredRepositories = new List<Type>() { typeof(Customer), typeof(Stock), typeof(Rental), typeof(Customer), typeof(Movie) };
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;

                List<TotalRentalHistoryViewModel> _totalMoviesRentalHistory = new List<TotalRentalHistoryViewModel>();
                var movies = _moviesRepository.GetAll().ToList();
                foreach (var movie in movies)
                {
                    TotalRentalHistoryViewModel _totalRentalHistory = new TotalRentalHistoryViewModel()
                    {
                        ID = movie.ID,
                        Title = movie.Title,
                        Image = movie.Image,
                        Rentals = GetMovieRentalHistoryPerDates(movie.ID)
                    };
                    if (_totalRentalHistory.TotalRentals > 0)
                    {
                        _totalMoviesRentalHistory.Add(_totalRentalHistory);
                    }
                }
                response = request.CreateResponse(HttpStatusCode.OK, _totalMoviesRentalHistory);
                return response;
            });
        }

        #region Private methods

        private List<RentalHistoryViewModel> GetMovieRentalHistory(int movieId)
        {
            List<RentalHistoryViewModel> _rentalHistory = new List<RentalHistoryViewModel>();
            List<Rental> rentals = new List<Rental>();

            var movie = _moviesRepository.GetSingle(movieId);

            foreach (var stock in movie.Stocks)
            {
                rentals.AddRange(stock.Rentals);
            }

            foreach (var rental in rentals)
            {
                RentalHistoryViewModel _rentalHistoryItem = new RentalHistoryViewModel
                {
                    ID = rental.ID,
                    StockId = rental.StockID,
                    RentalDate = rental.RentalDate,
                    ReturnedDate = rental.ReturnedDate.HasValue ? rental.ReturnedDate : null,
                    Status = rental.Status,
                    Customer = _customersRepository.GetCustomerFullName(rental.CustomerID)
                };

                _rentalHistory.Add(_rentalHistoryItem);
            }
            _rentalHistory.Sort((r1, r2) => r2.RentalDate.CompareTo(r1.RentalDate));
            return _rentalHistory;
        }

        private List<RentalHistoryPerDate> GetMovieRentalHistoryPerDates(int movieId)
        {
            List<RentalHistoryPerDate> listHistory = new List<RentalHistoryPerDate>();
            List<RentalHistoryViewModel> _rentalHistory = GetMovieRentalHistory(movieId);
            if (_rentalHistory.Count > 0)
            {
                List<DateTime> _distinctDates = new List<DateTime>();
                _distinctDates = _rentalHistory.Select(h => h.RentalDate.Date).Distinct().ToList();

                foreach (var distinctDate in _distinctDates)
                {
                    var totalDateRentals = _rentalHistory.Count(r => r.RentalDate.Date == distinctDate);
                    RentalHistoryPerDate _movieRentalHistoryPerDate = new RentalHistoryPerDate()
                    {
                        Date = distinctDate,
                        TotalRentals = totalDateRentals
                    };

                    listHistory.Add(_movieRentalHistoryPerDate);
                }

                listHistory.Sort((r1, r2) => r1.Date.CompareTo(r2.Date));
            }

            return listHistory;
        }

        #endregion Private methods
    }
}