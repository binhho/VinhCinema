using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using VinhCinema.Web.Infrastructure.Validators;

namespace VinhCinema.Web.Models
{
    public class StockViewModel : IValidatableObject
    {
        public int ID { get; set; }
        public Guid UniqueKey { get; set; }
        public bool IsAvailable { get; set; }

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            var validator = new StockViewModelValidator();
            var result = validator.Validate(this);
            return result.Errors.Select(i => new ValidationResult(i.ErrorMessage, new[] { i.PropertyName }));
        }
    }
}