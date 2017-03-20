using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;

namespace VinhCinema.Data.Extensions
{
    public static class StockExtensions
    {
        public static IEnumerable<Stock> GetAvailableItems(this IEntityBaseRepository<Stock> stocksRepository, int movieId)
        {
            IEnumerable<Stock> _availableItems;

            _availableItems = stocksRepository.GetAll().Where(s => s.MovieId == movieId && s.IsAvailable);

            return _availableItems;
        }
    }
}
