using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Capstone.DAO;
using Capstone.Models;


namespace Capstone.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]

    public class PropertiesController : ControllerBase
    {
        private readonly IPropertiesDao _propertiesDao;

        public PropertiesController(IPropertiesDao propertiesDao)
        {
            _propertiesDao = propertiesDao;
        }

        //[HttpGet]
        //[AllowAnonymous]
        //public ActionResult<List<PropertiesUnitsImages>> GetAllProperties() {
        //    return Ok(_propertiesDao.GetAllPropertiesUnitsImages());
        //}

        [HttpGet]
        [AllowAnonymous]
        public ActionResult<List<PropertiesWithAvailableUnits>> GetAllPropertiesWithAvailableUnits()
        {
            return Ok(_propertiesDao.GetAllPropertiesWithAvailableUnits());
        }

        [HttpPost]
        [Authorize(Roles = "Owner")]
        public ActionResult CreateProperty(Property property)
        {
            int ownerId = Convert.ToInt32(User.FindFirst("sub")?.Value);

            _propertiesDao.CreateNewProperty(property, ownerId);
            return NoContent();
        }

        [HttpPut("{propertyId}")]
        [Authorize(Roles = "Owner")]
        public ActionResult UpdateProperty(int propertyId, Property property)
        {
            int ownerId = Convert.ToInt32(User.FindFirst("sub")?.Value);

            _propertiesDao.UpdateProperty(property, ownerId, propertyId);
            return NoContent();
        }


    }

}

