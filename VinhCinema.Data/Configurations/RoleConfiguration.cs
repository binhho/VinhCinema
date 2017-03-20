using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Entities;

namespace VinhCinema.Data.Configurations
{
    public class RoleConfiguration : EntityBaseConfiguration<Role>
    {
        public RoleConfiguration()
        {
            Property(ur => ur.Name).IsRequired().HasMaxLength(50);
        }
    }
}
