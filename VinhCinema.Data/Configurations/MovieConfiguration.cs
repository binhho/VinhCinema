using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Entities;

namespace VinhCinema.Data.Configurations
{
    public class MovieConfiguration : EntityBaseConfiguration<Movie>
    {
        public MovieConfiguration()
        {
            Property(m => m.Title).IsRequired().HasMaxLength(100);
            Property(m => m.GenreID).IsRequired();
            Property(m => m.Director).IsRequired().HasMaxLength(100);
            Property(m => m.Writer).IsRequired().HasMaxLength(50);
            Property(m => m.Producer).IsRequired().HasMaxLength(50);
            Property(m => m.Writer).HasMaxLength(50);
            Property(m => m.Producer).HasMaxLength(50);
            Property(m => m.Rating).IsRequired();
            Property(m => m.Description).IsRequired().HasMaxLength(2000);
            Property(m => m.TrailerURI).HasMaxLength(200);
            HasMany(m => m.Stocks).WithRequired().HasForeignKey(s => s.MovieId);
        }
    }
}
