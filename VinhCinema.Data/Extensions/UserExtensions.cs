using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;

namespace VinhCinema.Data.Extensions
{
    public static class UserExtensions
    {
        public static User GetSingleByUserName(this IEntityBaseRepository<User> userRepository, string username)
        {
            return userRepository.GetAll().FirstOrDefault(x => x.Username == username);
        }
    }
}
