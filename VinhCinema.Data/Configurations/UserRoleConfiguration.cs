using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Entities;

namespace VinhCinema.Data.Configurations
{
    public class UserRoleConfiguration : EntityBaseConfiguration<UserRole>
    {
        public UserRoleConfiguration()
        {
            Property(ur => ur.UserId).IsRequired();
            Property(ur => ur.RoleId).IsRequired();
        }
    }
}
