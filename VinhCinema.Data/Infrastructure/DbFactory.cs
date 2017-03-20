using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VinhCinema.Data.Infrastructure
{
    public class DbFactory: Disposable, IDbFactory
    {
        VinhCinemaContext dbContext;

        public VinhCinemaContext Init()
        {
            return dbContext ?? (dbContext = new VinhCinemaContext());
        }

        protected override void DisposeCore()
        {
            if (dbContext != null)
            {
                dbContext.Dispose();
            }
        }
    }
}
