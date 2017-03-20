using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Infrastructure.Validators
{
    public class LoginViewModelValidator: AbstractValidator<LoginViewModel>
    {
        public LoginViewModelValidator()
        {
            RuleFor(r => r.UserName).NotEmpty()
                .WithMessage("Invalid username");

            RuleFor(r => r.Password).NotEmpty()
                .WithMessage("Invalid password");
        }
    }
}