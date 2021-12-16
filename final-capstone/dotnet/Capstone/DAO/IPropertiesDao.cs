using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IPropertiesDao
    {
        IList<PropertiesWithAvailableUnits> GetAllPropertiesWithAvailableUnits();
        void CreateNewProperty(Property property, int ownerId);
        void UpdateProperty(Property property, int ownerId, int propertyId);
        IList<PropertyByOwnerId> GetAllPropertiesByOwnerid(int ownerId);
        
    }
}
