using System;
using VinhCinema.Entities;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Infrastructure.Extensions
{
    public static class EntitiesExtensions
    {
        public static void UpdateMovie(this Movie movie, MovieViewModel movieVm)
        {
            movie.Title = movieVm.Title;
            movie.Description = movieVm.Description;
            movie.GenreID = movieVm.GenreId;
            movie.Director = movieVm.Director;
            movie.Writer = movieVm.Writer;
            movie.Producer = movieVm.Producer;
            movie.Rating = movieVm.Rating;
            movie.TrailerURI = movieVm.TrailerURI;
            movie.ReleaseDate = movieVm.ReleaseDate;
        }

        public static void UpdateCustomer(this Customer customer, CustomerViewModel customerVm)
        {
            customer.FirstName = customerVm.FirstName;
            customer.LastName = customerVm.LastName;
            customer.IdentityCard = customerVm.IdentityCard;
            customer.Mobile = customerVm.Mobile;
            customer.DateOfBirth = customerVm.DateOfBirth;
            customer.Email = customerVm.Email;
            customer.UniqueKey = (customerVm.UniqueKey == null || customerVm.UniqueKey == Guid.Empty)
                ? Guid.NewGuid() : customerVm.UniqueKey;
            customer.RegistrationDate = (customer.RegistrationDate == DateTime.MinValue ? DateTime.Now : customerVm.RegistrationDate);
        }
    }
}