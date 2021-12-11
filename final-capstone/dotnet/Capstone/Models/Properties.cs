namespace Capstone.Models
{
    public class PropertiesWithAvailableUnits
    {
        public int propertyId { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string address { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string zipCode { get; set; }
        public string imageUrl { get; set; }
        public int availableUnits { get; set; }
    }
}