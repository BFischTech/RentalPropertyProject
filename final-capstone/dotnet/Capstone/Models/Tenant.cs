using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class TenantWithoutRentedUnit
    {
        public int tenantId { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string email { get; set; }
        public string mobileNumber { get; set; }
    }

    public class UnitAndTenant {
        public int unitId { get; set; }
        public int tenantId { get; set; }
    }

    public class TenantRent
    
    {
        public decimal amount { get; set; }
        public int tenantId { get; set; }
        public string dateRentPaid { get; set; }
        
        
    }
    
}
