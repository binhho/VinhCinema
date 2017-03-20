using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;
using VinhCinema.Web.Infrastructure.Core;
using VinhCinema.Data.Extensions;
using VinhCinema.Web.Models;
using AutoMapper;

namespace VinhCinema.Web.Controllers
{
    [Authorize(Roles = "Admin")]
    [RoutePrefix("api/stocks")]
    public class StocksController : ApiControllerBaseExtended
    {
        public StocksController(IDataRepositoryFactory dataRepositoryFactory, IUnitOfWork unitOfWork) 
            : base(dataRepositoryFactory, unitOfWork)
        {
        }

        [Route("movie/{id:int}")]
        public IHttpActionResult Get(HttpRequestMessage request, int id)
        {
            _requiredRepositories = new List<Type>() { typeof(Stock) };
            return CreateHttpResponse(request, _requiredRepositories, () =>
            {
                HttpResponseMessage response = null;
                var stocks = _stocksRepository.GetAvailableItems(id);
                IEnumerable<StockViewModel> stocksVM = Mapper.Map<IEnumerable<Stock>, IEnumerable<StockViewModel>>(stocks);
                response = request.CreateResponse(HttpStatusCode.OK, stocksVM);
                return response;
            });
        }
    }
}
