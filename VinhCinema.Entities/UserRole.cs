using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VinhCinema.Entities
{
    public class UserRole : IEntityBase
    {
        public int ID { get; set; }
        public int UserId { get; set; }
        public int RoleId { get; set; }
        public virtual Role Role { get; set; }
    }
}
