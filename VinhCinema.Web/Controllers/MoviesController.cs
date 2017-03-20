using AutoMapper;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;
using VinhCinema.Web.Infrastructure.Core;
using VinhCinema.Web.Infrastructure.Extensions;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Controllers
{
    [Authorize(Roles = "Admin")]
    [RoutePrefix("api/movies")]
    public class MoviesController : ApiControllerBaseExtended
    {
        public MoviesController(IDataRepositoryFactory dataRepositoryFactory, IUnitOfWork unitOfWork)
            : base(dataRepositoryFactory, unitOfWork) { }

        [AllowAnonymous]
        [HttpGet]
        [Route("all")]
        public IHttpActionResult All(HttpRequestMessage request)
        {
            _requiredRepositories = new List<Type>() { typeof(Movie) };
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                var movies = _moviesRepository.GetAll().OrderByDescending(m => m.ReleaseDate).Take(6).ToList();

                IEnumerable<MovieViewModel> moviesVM = Mapper.Map<IEnumerable<Movie>, IEnumerable<MovieViewModel>>(movies);

                response = request.CreateResponse(HttpStatusCode.OK, moviesVM);

                return response;
            });
        }

        [HttpGet]
        [Route("details/{id:int}")]
        public IHttpActionResult GetByID(HttpRequestMessage request, int id)
        {
            _requiredRepositories = new List<Type>() { typeof(Movie) };
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                var movie = _moviesRepository.GetSingle(id);
                MovieViewModel movieVM = Mapper.Map<Movie, MovieViewModel>(movie);
                response = request.CreateResponse(HttpStatusCode.OK, movieVM);
                return response;
            });
        }

        [HttpGet]
        [Route("search/{page:int=0}/{pageSize=3}/{filter?}")]
        public IHttpActionResult GetByFilter(HttpRequestMessage request, int? page, int? pageSize, string filter = null)
        {
            _requiredRepositories = new List<Type>() { typeof(Movie) };
            int currentPage = page.Value;
            int currentPageSize = pageSize.Value;
            //string url = request.RequestUri.AbsolutePath.ToString();
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                List<Movie> movies = new List<Movie>();
                int totalMovies = 0;
                if (!string.IsNullOrEmpty(filter))
                {
                    movies = _moviesRepository.FindBy(m => m.Title.ToLower().Contains(filter.ToLower().Trim()))
                                .OrderBy(m => m.ID)
                                .Skip(currentPage * currentPageSize)
                                .Take(currentPageSize)
                                .ToList();
                    totalMovies = _moviesRepository.FindBy(m => m.Title.ToLower().Contains(filter.ToLower().Trim()))
                                                .Count();
                }
                else
                {
                    movies = _moviesRepository.GetAll()
                                .OrderBy(m => m.ID)
                                .Skip(currentPage * currentPageSize)
                                .Take(currentPageSize)
                                .ToList();
                    totalMovies = _moviesRepository.GetAll().Count();
                }

                IEnumerable<MovieViewModel> moviesVM = Mapper.Map<IEnumerable<Movie>, IEnumerable<MovieViewModel>>(movies);

                PaginationSet<MovieViewModel> pagedSet = new PaginationSet<MovieViewModel>()
                {
                    Page = currentPage,
                    TotalCount = totalMovies,
                    TotalPages = (int)Math.Ceiling((decimal)totalMovies / currentPageSize),
                    Items = moviesVM
                };

                response = request.CreateResponse(HttpStatusCode.OK, pagedSet);

                return response;
            });
        }

        [MimeMultipart]
        [Route("images/upload")]
        public IHttpActionResult Upload(HttpRequestMessage request, int movieID)
        {
            _requiredRepositories = new List<Type>() { typeof(Movie) };
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                var movieOld = _moviesRepository.GetSingle(movieID);
                if (movieOld == null)
                {
                    response = request.CreateErrorResponse(HttpStatusCode.NotFound, "Invalid movie");
                }
                else
                {
                    var uploadPath = HttpContext.Current.Server.MapPath("~/Content/images/movies");

                    var multipartFormDataStreamProvider = new UploadMultipartFormProvider(uploadPath);

                    Request.Content.ReadAsMultipartAsync(multipartFormDataStreamProvider);

                    string _localFileName = multipartFormDataStreamProvider.FileData.Select(multiData => multiData.LocalFileName).FirstOrDefault();

                    FileUploadResult fileUploadResult = new FileUploadResult()
                    {
                        LocalFilePath = _localFileName,
                        FileName = Path.GetFileName(_localFileName),
                        FileLength = new FileInfo(_localFileName).Length
                    };

                    movieOld.Image = fileUploadResult.FileName;
                    _moviesRepository.Edit(movieOld);
                    _unitOfWork.Commit();

                    response = request.CreateResponse(HttpStatusCode.OK, fileUploadResult);
                }
                return response;
            });
        }

        [MimeMultipart]
        [Route("images/AddUpload")]
        public async Task<IHttpActionResult> Upload(HttpRequestMessage request)
        {
            //_requiredRepositories = new List<Type>() { typeof(Movie) };

            #region Thread
            var photos = new List<FileUploadResult>();

            HttpResponseMessage response = null;
            IHttpActionResult responseMG = null;

            var uploadPath = HttpContext.Current.Server.MapPath("~/Content/images/movies");

            var multipartFormDataStreamProvider = new UploadMultipartFormProvider(uploadPath);

            await request.Content.ReadAsMultipartAsync(multipartFormDataStreamProvider);

            //string _localFileName = multipartFormDataStreamProvider.FileData.Select(multiData => multiData.LocalFileName).FirstOrDefault();

            foreach (var file in multipartFormDataStreamProvider.FileData)
            {
                var fileInfo = new FileInfo(file.LocalFileName);
                photos.Add(new FileUploadResult
                {
                    LocalFilePath = file.LocalFileName,
                    FileName = fileInfo.Name,
                    FileLength = fileInfo.Length / 1024
                });
            }

            response = request.CreateResponse(HttpStatusCode.OK, photos);
            responseMG = ResponseMessage(response);
            return responseMG;

            #endregion Thread

            //return CreateHttpResponse(request, _requiredRepositories, async () =>
            //{
            //    HttpResponseMessage response = null;

            //    var uploadPath = HttpContext.Current.Server.MapPath("~/Content/images/movies");

            //    var multipartFormDataStreamProvider = new UploadMultipartFormProvider(uploadPath);

            //    await request.Content.ReadAsMultipartAsync(multipartFormDataStreamProvider);

            //    string _localFileName = multipartFormDataStreamProvider.FileData.Select(multiData => multiData.LocalFileName).FirstOrDefault();

            //    FileUploadResult fileUploadResult = new FileUploadResult()
            //    {
            //        LocalFilePath = _localFileName,
            //        FileName = Path.GetFileName(_localFileName),
            //        FileLength = new FileInfo(_localFileName).Length
            //    };

            //    response = request.CreateResponse(HttpStatusCode.OK, fileUploadResult);

            //    return response;
            //});
        }

        [HttpPost]
        [Route("update")]
        public IHttpActionResult Update(HttpRequestMessage request, MovieViewModel movie)
        {
            _requiredRepositories = new List<Type>() { typeof(Movie) };

            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;

                if (!ModelState.IsValid)
                {
                    response = request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
                }
                else
                {
                    var movieDb = _moviesRepository.GetSingle(movie.ID);
                    if (movieDb == null)
                        response = request.CreateErrorResponse(HttpStatusCode.NotFound, "Invalid movie.");
                    else
                    {
                        movieDb.UpdateMovie(movie);
                        movieDb.Image = movie.Image;
                        _moviesRepository.Edit(movieDb);

                        _unitOfWork.Commit();
                        response = request.CreateResponse(HttpStatusCode.OK, movie);
                    }
                }

                return response;
            });
        }

        [HttpPost]
        [Route("add")]
        public IHttpActionResult Add(HttpRequestMessage request, MovieViewModel movie)
        {
            _requiredRepositories = new List<Type>() { typeof(Movie), typeof(Stock) };

            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;

                if (!ModelState.IsValid)
                {
                    response = request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
                }
                else
                {
                    Movie newMovie = new Movie();
                    newMovie.UpdateMovie(movie);

                    for (int i = 0; i < movie.NumberOfStocks; i++)
                    {
                        Stock stock = new Stock()
                        {
                            IsAvailable = true,
                            Movie = newMovie,
                            UniqueKey = Guid.NewGuid()
                        };
                        newMovie.Stocks.Add(stock);
                    }

                    _moviesRepository.Add(newMovie);

                    _unitOfWork.Commit();

                    // Update view model
                    movie = Mapper.Map<Movie, MovieViewModel>(newMovie);
                    response = request.CreateResponse(HttpStatusCode.Created, movie);
                }

                return response;
            });
        }
    }
}