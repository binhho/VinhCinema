using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VinhCinema.Entities
{
    public class Stock: IEntityBase
    {
        public Stock()
        {
            Rentals = new List<Rental>();
        }
        public int ID { get; set; }
        public int MovieId { get; set; }
        public Guid UniqueKey { get; set; }
        public bool IsAvailable { get; set; }
        public virtual ICollection<Rental> Rentals { get; set; }

        [ForeignKey("MovieId")]
        public virtual Movie Movie { get; set; }
    }
}
