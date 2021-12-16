using Microsoft.AspNetCore.Mvc;
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
    
    public class TenantController : ControllerBase
    {
        private readonly ITenantDao _tenantDao;
        
        public TenantController (ITenantDao tenantDao)
        {
            _tenantDao = tenantDao;
        }
        
        [HttpPost]
        [Authorize(Roles = "Tenant")]
        public ActionResult PayRent (TenantRent tenantRent)
        {
            _tenantDao.TenantRent(tenantRent);
            
            return NoContent();
        }
    }
}