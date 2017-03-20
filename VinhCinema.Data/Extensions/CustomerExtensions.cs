using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VinhCinema.Data.Infrastructure;
using VinhCinema.Entities;

namespace VinhCinema.Data.Extensions
{
    public static class CustomerExtensions
    {
        public static bool UserExists(this IEntityBaseRepository<Customer> customersRepository, string email, string identityCard)
        {
            bool _userExist = false;
            _userExist = customersRepository.GetAll()
                .Any(c => c.Email.ToLower() == email || 
                c.IdentityCard.ToLower() == identityCard);
            return _userExist;
        }

        public static string GetCustomerFullName(this IEntityBaseRepository<Customer> customersRepository, int customerId)
        {
            string _customerName = string.Empty;

            var _customer = customersRepository.GetSingle(customerId);

            _customerName = _customer.FirstName + " " + _customer.LastName;

            return _customerName;
        }
    }
}
