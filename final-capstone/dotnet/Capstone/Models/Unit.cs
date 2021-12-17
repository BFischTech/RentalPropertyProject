using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class UnitWithImages {
        public IList<Unit> Unit { get; set; }
        public IList<Images> Image { get; set; }

        public UnitWithImages(IList<Unit> units, IList<Images> image) {
            Unit = units;
            Image = image;
        }

    }

    public class UnitAvailableByOwnerIdListOfTenentWithoutRentedUnit {
        public IList<AvailbleUnitsByOwnerId> Unit { get; set; }
        public IList<TenantWithoutRentedUnit> Tenant { get; set; }

        public UnitAvailableByOwnerIdListOfTenentWithoutRentedUnit(IList<AvailbleUnitsByOwnerId> availbleUnitsByOwnerId, IList<TenantWithoutRentedUnit> tenantWithoutRentedUnit) {
            Unit = availbleUnitsByOwnerId;
            Tenant = tenantWithoutRentedUnit;
        }

    }

    public class AvailbleUnitsByOwnerId {
        public int unitId { get; set; }
        public string unitType { get; set; }
    }

    public class Unit
    {
        public int unitId { get; set; }
        public string unitType { get; set; }
        public int bedroomCount { get; set; }
        public decimal bathroomCount { get; set; }
        public bool petFriendly { get; set; }
        public bool nonSmoking { get; set; }
        public bool poolAccess { get; set; } = false;
        public int parkingSpots { get; set; } = 0;
        public decimal rentAmount { get; set; }
        public bool isRented { get; set; }
        public string rentDueDate { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public int unitBuildingNumber { get; set; }
        public string unitNumber { get; set; }
        public string address { get; set; }
        public string unitCity { get; set; }
        public string unitState { get; set; }
        public string unitZipCode { get; set; }

    }

    public class AvailableUnits
    {
        public int unitId { get; set; }
        public int propertyId { get; set; }
        public string unitType { get; set; }
        public decimal unitRentAmount { get; set; }
        public int buildingNumber { get; set; }
        public string unitNumber { get; set; }
        public string unitAddress { get; set; }
        public string unitCity { get; set; }
        public string unitZipCode { get; set; }
        public string imgUrl { get; set; }

    }

    public class DetailedUnit
    {
        public int propertyId { get; set; }
        public int unitId { get; set; }
        public string unitType { get; set; }
        public decimal unitRentAmount { get; set; }
        public int buildingNumber { get; set; }
        public string unitNumber { get; set; }
        public string unitAddress { get; set; }
        public string unitCity { get; set; }
        public string unitZipCode { get; set; }
        public string imgUrl { get; set; }
        public int bedroomCount { get; set; }
        public decimal bathroomCount { get; set; }
        public bool petFriendly { get; set; }
        public bool smokingAllowed { get; set; }
        public bool poolAccess { get; set; } = false;
        public decimal parkingSpots { get; set; } = 0;


    }

    public class CreateUnit
    {
        public int propertyId { get; set; }
        public int unitType { get; set; }
        public decimal unitRentAmount { get; set; }
        public int rentDueDate { get; set; }
        public int buildingNumber { get; set; }
        public string unitNumber { get; set; }
        public string unitAddress { get; set; }
        public string unitCity { get; set; }
        public string unitState { get; set; }
        public string unitZipCode { get; set; }
        public string imgUrl { get; set; }
        public int bedroomCount { get; set; }
        public decimal bathroomCount { get; set; }
        public bool petFriendly { get; set; }
        public bool smokingAllowed { get; set; }
        public bool poolAccess { get; set; } = false;
        public decimal parkingSpots { get; set; } = 0;
    }
}
