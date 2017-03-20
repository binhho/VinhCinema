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
using VinhCinema.Web.Infrastructure.Extensions;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Controllers
{
    [Authorize(Roles = "Admin")]
    [RoutePrefix("api/customers")]
    public class CustomersController : ApiControllerBase
    {
        private readonly IEntityBaseRepository<Customer> _customersRepository;

        public CustomersController(IEntityBaseRepository<Customer> customersRepository
            , IEntityBaseRepository<Error> _errorsRepository, IUnitOfWork _unitOfWork)
            : base(_errorsRepository, _unitOfWork)
        {
            _customersRepository = customersRepository;
        }

        public IHttpActionResult Get(HttpRequestMessage request, string filter)
        {
            filter = filter.ToLower().Trim();
            return CreateHttpResponse(request, () =>
            {
                HttpResponseMessage response = null;
                var customers = _customersRepository.GetAll().Where(c => c.Email.ToLower().Contains(filter) ||
                        c.FirstName.ToLower().Contains(filter) || c.LastName.ToLower().Contains(filter)).ToList();

                var customersVm = Mapper.Map<IEnumerable<Customer>, IEnumerable<CustomerViewModel>>(customers);

                response = request.CreateResponse(HttpStatusCode.OK, customersVm);
                return response;
            });
        }

        [HttpGet]
        [Route("search/{page:int=0}/{pageSize=4}/{filter?}")]
        public IHttpActionResult Search(HttpRequestMessage request, int? page, int? pageSize, string filter = null)
        {
            int CurrentPage = page.Value;
            int CurrentPageSize = pageSize.Value;

            return CreateHttpResponse(request, () =>
            {
                HttpResponseMessage response = null;
                List<Customer> customers = new List<Customer>();
                int totalCustomers;
                if (!string.IsNullOrEmpty(filter))
                {
                    filter = filter.Trim().ToLower();
                    customers = _customersRepository
                                    .FindBy(c => c.LastName.ToLower().Contains(filter) ||
                                            c.IdentityCard.ToLower().Contains(filter) ||
                                            c.FirstName.ToLower().Contains(filter))
                                    .OrderBy(c => c.ID)
                                    .Skip(CurrentPage * CurrentPageSize)
                                    .Take(CurrentPageSize)
                                    .ToList();
                    totalCustomers = _customersRepository.GetAll().Where(c => c.LastName.ToLower().Contains(filter) ||
                                            c.IdentityCard.ToLower().Contains(filter) ||
                                            c.FirstName.ToLower().Contains(filter)).Count();
                }
                else
                {
                    customers = _customersRepository.GetAll().OrderBy(c => c.ID)
                                    .Skip(CurrentPage * CurrentPageSize)
                                    .Take(CurrentPageSize)
                                    .ToList();
                    totalCustomers = _customersRepository.GetAll().Count();
                }
                IEnumerable<CustomerViewModel> customersVM = Mapper.Map<IEnumerable<Customer>, IEnumerable<CustomerViewModel>>(customers);
                PaginationSet<CustomerViewModel> customerPage = new PaginationSet<CustomerViewModel>()
                {
                    Page = CurrentPage,
                    TotalPages = (int)Math.Ceiling((decimal)totalCustomers / CurrentPageSize),
                    TotalCount = totalCustomers,
                    Items = customersVM
                };
                response = request.CreateResponse(HttpStatusCode.OK, customerPage);
                return response;
            });
        }

        [HttpPost]
        [Route("update")]
        public IHttpActionResult Update(HttpRequestMessage request, CustomerViewModel customer)
        {
            return CreateHttpResponse(request, () =>
            {
                HttpResponseMessage response = null;
                if (!ModelState.IsValid)
                {
                    response = request.CreateResponse(HttpStatusCode.BadRequest,
                        ModelState.Keys
                        .SelectMany(k => ModelState[k].Errors)
                        .Select(m => m.ErrorMessage).ToArray());
                }
                else
                {
                    Customer _customer = _customersRepository.GetSingle(customer.ID);
                    _customer.UpdateCustomer(customer);
                    _unitOfWork.Commit();
                    response = request.CreateResponse(HttpStatusCode.Created, _customer);
                }
                return response;
            });
        }

        [HttpPost]
        [Route("register")]
        public IHttpActionResult Register(HttpRequestMessage request, CustomerViewModel customer)
        {
            return CreateHttpResponse(request, () =>
            {
                HttpResponseMessage response = null;
                if (!ModelState.IsValid)
                {
                    response = request.CreateResponse(HttpStatusCode.BadRequest,
                        ModelState.Keys
                        .SelectMany(k => ModelState[k].Errors)
                        .Select(m => m.ErrorMessage).ToArray());
                }
                else
                {
                    if (_customersRepository.UserExists(customer.Email, customer.IdentityCard))
                    {
                        ModelState.AddModelError("Invalid User", "Email or Identity Card have existed");
                        response = request.CreateResponse(HttpStatusCode.BadRequest,
                            ModelState.Keys
                            .SelectMany(k => ModelState[k].Errors)
                            .Select(m => m.ErrorMessage).ToArray());
                    }
                    else
                    {
                        Customer newCustomer = new Customer();
                        newCustomer.UpdateCustomer(customer);
                        _customersRepository.Add(newCustomer);
                        _unitOfWork.Commit();
                        customer = Mapper.Map<Customer, CustomerViewModel>(newCustomer);

                        response = request.CreateResponse(HttpStatusCode.Created, customer);
                    }
                }
                return response;
            });
        }
    }
}