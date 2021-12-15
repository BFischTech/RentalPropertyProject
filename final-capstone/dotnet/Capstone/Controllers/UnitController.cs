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

        public UnitController(IUnitDao unitDao, IImagesDao imagesDao) {
            _unitDao = unitDao;
            _imagesDao = imagesDao;
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

        [HttpGet("AvailableUnits")]
        [AllowAnonymous]
        public ActionResult<List<AvailableUnits>> GetAvailableUnits()
        {
            return Ok(_unitDao.GetAllAvailableUnits());
        }



        //[HttpGet("/property/{unitId}")]
        //[AllowAnonymous]
        //public ActionResult<DetailedUnit> UnitDetails(int unitId)
        //{
        //    return Ok(_unitDao.GetUnitDetails(unitId));
        //}
    }
}
