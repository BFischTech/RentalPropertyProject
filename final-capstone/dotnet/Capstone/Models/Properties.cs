namespace Capstone.Models
{
    public class PropertiesWithAvailableUnits
    {
        public int propertyId { get; set; }
        public decimal rentAmount { get; set; }
        public string propertyType { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string address { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string zipCode { get; set; }
        public string imageUrl { get; set; }
        public int bedroomCount { get; set; }
        public int bathroomCount { get; set; }
        public int availableUnits { get; set; }
    }

    public class NewPropertyPost
    {
        public string propertyName { get; set; }
        public string propertyDescription { get; set; }
        public string propertyAddress { get; set; }
        public string propertyCity { get; set; }
        public string propertyState { get; set; }
        public string propertyZipCode { get; set; }
        public string propertyImgUrl { get; set; }
        public int propertyOwnerId { get; set; }
    }

}