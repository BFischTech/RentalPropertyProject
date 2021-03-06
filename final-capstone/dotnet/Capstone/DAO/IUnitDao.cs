using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public interface IUnitDao
    {
        IList<Unit> GetAllUnits();

        IList<Unit> GetUnitsByPropertyId(int id);

        IList<AvailableUnits> GetAllAvailableUnits();

        DetailedUnit GetUnitDetails(int unitId);

        IList<AvailbleUnitsByOwnerId> GetAllAvailableUnitsByOwnerId(int ownerId);

        void CreateNewUnit(CreateUnit createUnit);
    }
}
