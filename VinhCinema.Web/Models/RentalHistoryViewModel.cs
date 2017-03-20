using System;

namespace VinhCinema.Web.Models
{
    public class RentalHistoryViewModel
    {
        public int ID { get; set; }
        public int StockId { get; set; }
        public string Customer { get; set; }
        public string Status { get; set; }
        public DateTime RentalDate { get; set; }
        public DateTime? ReturnedDate { get; set; }
    }
}