namespace Capstone.Models
{
    // public class Properties
    // {  
    //     public int propertyId { get; set; }
    //     public string propertyName { get; set; }
    //     public string propertyDescription { get; set; }
    //     public string address { get; set; }
    //     public string city { get; set; }
    //     public string state { get; set; }
    //     public string zipCode { get; set; }
    // }

    public class PropertiesUnitsImages
    {  
        public int propertyId { get; set; }
        public string propertyName { get; set; }
        public string propertyDescription { get; set; }
        public string address { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string zipCode { get; set; }
        public int bedroomCount { get; set; }
        public decimal bathroomCount { get; set; }
        public bool petFriendly { get; set; }  
        public bool nonSmoking { get; set; }    
        public bool poolAccess { get; set; }   
        public decimal parkingSpots { get; set; }
        public decimal rentAmount { get; set; }		
        public bool isRented { get; set; }		
        public string rentDueDate { get; set; }
        public string imageUrl { get; set; }
    }
}