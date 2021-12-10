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

        public PropertiesController(IPropertiesDao propertiesDao) {
            _propertiesDao = propertiesDao;
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult<List<Properties>> GetAllProperties() {
            return Ok(_propertiesDao.GetAllProperties());
        }
    }
}
