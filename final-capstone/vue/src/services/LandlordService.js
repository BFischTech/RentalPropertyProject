import axios from 'axios';

export default {

    GetAllAvailableUnitsByOwnerAndTenantWithoutRentedUnit() {
        return axios.get('/unit/owner')
    },

    AssignTenantToUnit(unitAndTenant) {
        return axios.put('unit/owner/update', unitAndTenant)
    },

    getMaintenanceForOwner() {
        return axios.get('/MaintenanceRequest/owner')
    },
}