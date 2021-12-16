using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]

    public class UnitController : ControllerBase {
        private readonly IUnitDao _unitDao;
        private readonly IImagesDao _imagesDao;
        private readonly ITenantDao _tenantDao;

        public UnitController(IUnitDao unitDao, IImagesDao imagesDao, ITenantDao tenantDao) {
            _unitDao = unitDao;
            _imagesDao = imagesDao;
            _tenantDao = tenantDao;
        }

        //get all units as a list
        [HttpGet]
        [AllowAnonymous]
        public ActionResult<List<Unit>> GetAllUnits() {
            return Ok(_unitDao.GetAllUnits());
        }

        //get all units by propertyId as a list
        [HttpGet("{id}")]
        [AllowAnonymous]
        public ActionResult<UnitWithImages>  GetAllUnitsByPropertyId(int id) {

            var units = _unitDao.GetUnitsByPropertyId(id);
            var images = _imagesDao.GetAllUnitImagesByPropertyId(id);
            UnitWithImages unitWithImages = new UnitWithImages(units, images);

            return Ok(unitWithImages);

        }

        [HttpGet("owner")]
        [Authorize(Roles ="Owner")]
        public ActionResult<UnitAvailableByOwnerIdListOfTenentWithoutRentedUnit>  GetAllAvailableUnitsByOwnerAndTenantWithoutRentedUnit() {


            int ownerId = Convert.ToInt32(User.FindFirst("sub")?.Value);
            var units = _unitDao.GetAllAvailableUnitsByOwnerId(ownerId);
            var tenants = _tenantDao.GetAllTenantWithoutRentedUnit();
            UnitAvailableByOwnerIdListOfTenentWithoutRentedUnit unitAvailableAndTenantWithoutRentedUnit = new UnitAvailableByOwnerIdListOfTenentWithoutRentedUnit(units, tenants);

            return Ok(unitAvailableAndTenantWithoutRentedUnit);

        }

        
        [HttpPut("owner/update")]
        [Authorize(Roles ="Owner")]
        public ActionResult AssignTenantToAvailableUnit(UnitAndTenant unitAndTenant) {
            _tenantDao.AssignTenantToAvailableUnit(unitAndTenant);
            return NoContent();
        }

        //[HttpGet("/property/{unitId}")]
        //[AllowAnonymous]
        //public ActionResult<DetailedUnit> UnitDetails(int unitId)
        //{
        //    return Ok(_unitDao.GetUnitDetails(unitId));
        //}
    }
}
