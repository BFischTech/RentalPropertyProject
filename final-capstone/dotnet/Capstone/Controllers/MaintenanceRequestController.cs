using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]
    public class MaintenanceRequestController : ControllerBase
    {
        private readonly IMaintenceRequestsDao _maintenceRequestsDao;

        public MaintenanceRequestController(IMaintenceRequestsDao maintenceRequestsDao) {
            _maintenceRequestsDao = maintenceRequestsDao;
        }

        [HttpGet("owner")]
        [Authorize(Roles ="Admin, Owner")]
        public ActionResult<IList<MaintenanceRequestsByOwner>> GetMaintenanceRequestsByOwner() {
            return Ok(_maintenceRequestsDao.GetMaintenanceRequestsByOwner(Convert.ToInt32(User.FindFirst("sub")?.Value)));
        }

        [HttpGet("tenant")]
        [Authorize(Roles ="Admin, Tenant" )]
        public ActionResult<IList<MaintenanceRequestsByOwner>> GetMaintenanceRequestsByTenant() {
            return Ok(_maintenceRequestsDao.GetMaintenanceRequestsByTenant(Convert.ToInt32(User.FindFirst("sub")?.Value)));
        }
    }
}
