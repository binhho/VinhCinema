using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VinhCinema.Entities;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Infrastructure.Mappings
{
    public class AutoMapperConfiguration
    {
        public static void Configure()
        {
            Mapper.Initialize(cfg =>
            {
                cfg.CreateMap<Genre, GenreViewModel>().ForMember(vm => vm.NumberOfMovies, map => map.MapFrom(g => g.Movies.Count()));
                cfg.CreateMap<Movie, MovieViewModel>()
                    .ForMember(vm => vm.Genre, map => map.MapFrom(m => m.Genre.Name))
                    .ForMember(vm => vm.GenreId, map => map.MapFrom(m => m.Genre.ID))
                    .ForMember(vm => vm.IsAvailable, map => map.MapFrom(m => m.Stocks.Any(s => s.IsAvailable)))
                    .ForMember(vm => vm.NumberOfStocks, map => map.MapFrom(m => m.Stocks.Count))
                    .ForMember(vm => vm.Image, map => map.MapFrom(m => string.IsNullOrEmpty(m.Image) == true ? "unknown.jpg" : m.Image));
                cfg.CreateMap<Customer, CustomerViewModel>();
                cfg.CreateMap<Stock, StockViewModel>();
                cfg.CreateMap<Rental, RentalViewModel>();
            });
            Mapper.AssertConfigurationIsValid();
        }
    }
}