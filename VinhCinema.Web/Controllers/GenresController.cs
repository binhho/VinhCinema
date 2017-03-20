using AutoMapper;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;
using VinhCinema.Web.Infrastructure.Core;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Controllers
{
    [Authorize(Roles = "Admin")]
    [RoutePrefix("api/genres")]
    public class GenresController : ApiControllerBase
    {
        private readonly IEntityBaseRepository<Genre> _genresRepository;

        public GenresController(IEntityBaseRepository<Genre> genresRepository,
        IEntityBaseRepository<Error> _errorsRepository, IUnitOfWork _unitOfWork)
        : base(_errorsRepository, _unitOfWork)
        {
            _genresRepository = genresRepository;
        }

        [AllowAnonymous]
        [HttpGet]
        [Route("all")]
        public IHttpActionResult All(HttpRequestMessage request)
        {
            return CreateHttpResponse(request, () =>
            {
                HttpResponseMessage response = null;
                var genres = _genresRepository.GetAll().ToList();
                var genresVM = Mapper.Map<IEnumerable<Genre>, IEnumerable<GenreViewModel>>(genres);
                response = request.CreateResponse(HttpStatusCode.OK, genresVM);
                return response;
            });
        }
    }
}