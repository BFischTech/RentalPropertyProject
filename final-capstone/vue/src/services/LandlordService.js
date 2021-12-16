import axios from 'axios';

export default {

    GetAllAvailableUnitsByOwnerAndTenantWithoutRentedUnit() {
        return axios.get('/unit/owner')
    },
}