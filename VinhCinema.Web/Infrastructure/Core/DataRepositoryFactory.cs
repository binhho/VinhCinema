using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;
using VinhCinema.Web.Infrastructure.Extensions;

namespace VinhCinema.Web.Infrastructure.Core
{
    public class DataRepositoryFactory : IDataRepositoryFactory
    {
        public IEntityBaseRepository<T> GetDataRepository<T>(HttpRequestMessage request) where T : class, IEntityBase, new()
        {
            return request.GetDataRepository<T>();
        }
    }

    public interface IDataRepositoryFactory
    {
        IEntityBaseRepository<T> GetDataRepository<T>(HttpRequestMessage request) where T : class, IEntityBase, new();
    }
}