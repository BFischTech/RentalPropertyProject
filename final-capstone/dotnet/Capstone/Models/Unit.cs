using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Unit
    {
        public int unitId { get; set; }
        public int bedroomCount { get; set; }
        public decimal bathroomCount { get; set; }
        public bool petFriendly { get; set; }
        public bool nonSmoking { get; set; }
        public bool? poolAccess { get; set; } = false;
        public decimal? parkingSpots { get; set; } = 0;
        public decimal rentAmount { get; set; }
        public bool isRented { get; set; }
        public string rentDueDate { get; set; }
        public int propertyId { get; set; }

    }
}
