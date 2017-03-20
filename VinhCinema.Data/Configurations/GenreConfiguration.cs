using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Entities;

namespace VinhCinema.Data.Configurations
{
    public class GenreConfiguration: EntityBaseConfiguration<Genre>
    {
        public GenreConfiguration()
        {
            Property(g => g.Name).IsRequired().HasMaxLength(50);
        }
    }
}
