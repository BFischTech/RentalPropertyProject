import axios from 'axios';

export default {

    getMaintenanceByID() {
        return axios.get('/MaintenanceRequest/employee')
    },

}