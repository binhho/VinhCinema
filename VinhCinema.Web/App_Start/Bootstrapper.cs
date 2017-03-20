using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using VinhCinema.Web.Infrastructure.Mappings;

namespace VinhCinema.Web.App_Start
{
    public class Bootstrapper
    {
        public static void Run()
        {
            AutofacWebapiConfig.Initialize(GlobalConfiguration.Configuration);
            AutoMapperConfiguration.Configure();
        }
    }
}