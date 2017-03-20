using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Entities;

namespace VinhCinema.Data.Configurations
{
    public class RentalConfiguration : EntityBaseConfiguration<Rental>
    {
        public RentalConfiguration()
        {
            Property(r => r.CustomerID).IsRequired();
            Property(r => r.StockID).IsRequired();
            Property(r => r.Status).IsRequired().HasMaxLength(10);
            Property(r => r.ReturnedDate).IsOptional();
        }
    }
}
