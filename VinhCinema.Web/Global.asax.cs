using System;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using VinhCinema.Web.App_Start;

namespace VinhCinema.Web
{
    public class Global : HttpApplication
    {
        private void Application_Start(object sender, EventArgs e)
        {
            var config = GlobalConfiguration.Configuration;

            AreaRegistration.RegisterAllAreas();
            WebApiConfig.Register(config);
            Bootstrapper.Run();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            GlobalConfiguration.Configuration.EnsureInitialized();
            //GlobalConfiguration.Configuration.Filters.Add(new CustomAuthorizeAttribute());
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}