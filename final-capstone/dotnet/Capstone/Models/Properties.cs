namespace Capstone.Models
{


    public class Properties
    {  

        public int propertyId { get; set; }
        public string address { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string zipcode { get; set; }
        public string unit { get; set; }
        public decimal rentAmount  { get; set; }
        public bool isRented { get; set; }
        public string rentDueDate { get; set; }

    }
}