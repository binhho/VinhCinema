using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VinhCinema.Web.Models;

namespace VinhCinema.Web.Infrastructure.MessageHandlers
{
    public class RegistrationViewModelValidator: AbstractValidator<RegistrationViewModel>
    {
        public RegistrationViewModelValidator()
        {
            RuleFor(r => r.Email).NotEmpty().EmailAddress()
                .WithMessage("Invalid email address");

            RuleFor(r => r.Username).NotEmpty()
                .WithMessage("Invalid username");

            RuleFor(r => r.Password).NotEmpty()
                .WithMessage("Invalid password");
        }
    }
}