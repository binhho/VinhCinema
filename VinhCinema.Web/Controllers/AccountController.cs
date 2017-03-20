using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;
using VinhCinema.Services;
using VinhCinema.Web.Infrastructure.Core;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Controllers
{
    
    [RoutePrefix("api/Account")]
    public class AccountController : ApiControllerBase
    {
        private readonly IMembershipService _membershipService;
        public AccountController(IMembershipService membershipService
            , IEntityBaseRepository<Error> _errorsRepository, IUnitOfWork unitOfWork) 
            : base(_errorsRepository, unitOfWork)
        {
            _membershipService = membershipService;
        }

        [AllowAnonymous]
        [Route("authenticate")]
        [HttpPost]
        public IHttpActionResult Login(HttpRequestMessage request, LoginViewModel user)
        {
            return CreateHttpResponse(request, () =>
            {
                HttpResponseMessage response = null;
                if (ModelState.IsValid)
                {
                    MembershipContext _userContext = _membershipService.ValidateUser(user.UserName, user.Password);
                    if (_userContext.User != null)
                    {
                        response = request.CreateResponse(HttpStatusCode.OK, new { success = true });
                    }
                    else
                    {
                        response = request.CreateResponse(HttpStatusCode.OK, new { success = false });
                    }
                }
                else
                {
                    response = request.CreateResponse(HttpStatusCode.OK, new { success = false });
                }
                return response;
            });
        }

        [AllowAnonymous]
        [Route("register")]
        [HttpPost]
        public IHttpActionResult Register(HttpRequestMessage request, RegistrationViewModel user)
        {
            return CreateHttpResponse(request, () =>
            {
                HttpResponseMessage response = null;
                if (!ModelState.IsValid)
                {
                    response = request.CreateResponse(HttpStatusCode.BadRequest, new { success = false });
                }
                else
                {
                    User _user = _membershipService.CreateUser(user.Username, user.Email, user.Password, new int[] { 1 });
                    if (_user != null)
                    {
                        response = request.CreateResponse(HttpStatusCode.OK, new { success = true });
                    }
                    else
                    {
                        response = request.CreateResponse(HttpStatusCode.OK, new { success = false });
                    }
                    
                }
                return response;
            });
        }
    }
}
