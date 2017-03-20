using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Entities;

namespace VinhCinema.Data.Infrastructure
{
    public class EntityBaseRepository<T> : IEntityBaseRepository<T> where T : class, IEntityBase, new()
    {
        private VinhCinemaContext dbContext;
        protected IDbFactory DbFactory
        {
            get;
            private set;
        }
        protected VinhCinemaContext DbContext
        {
            get { return dbContext ?? (dbContext = DbFactory.Init()); }
        }
        public EntityBaseRepository(IDbFactory dbFactory)
        {
            DbFactory = dbFactory;
        }

        public virtual IQueryable<T> GetAll()
        {
            return DbContext.Set<T>();
        }
        public virtual IQueryable<T> All
        {
            get
            {
                return GetAll();
            }
        }

        public virtual void Add(T entity)
        {
            DbContext.Set<T>().Add(entity);
        }

        public virtual IQueryable<T> AllIncluding(params Expression<Func<T, object>>[] includeProperties)
        {
            IQueryable<T> query = DbContext.Set<T>();
            foreach (var includeProperty in includeProperties)
            {
                query = query.Include(includeProperty);
            }
            return query;
        }

        public virtual void Delete(T entity)
        {
            
            DbEntityEntry dbEntityEntry = DbContext.Entry<T>(entity);
            dbEntityEntry.State = EntityState.Deleted;
        }

        public virtual void Edit(T entity)
        {
            DbContext.Set<T>().Attach(entity);
            dbContext.Entry(entity).State = EntityState.Modified;
        }

        public T GetSingle(int? id)
        {
            return GetAll().FirstOrDefault(x => x.ID == id);
        }
        public virtual IQueryable<T> FindBy(Expression<Func<T, bool>> predicate)
        {
            return DbContext.Set<T>().Where(predicate);
        }
    }
}
