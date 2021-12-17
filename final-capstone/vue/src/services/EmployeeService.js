import axios from 'axios';

export default {

    getMaintenanceByID() {
        return axios.get('/MaintenanceRequest/employee')
    },

    UpdateEmployeeStatus(statusIdRequestId) {
        return axios.put('/MaintenanceRequest/employee/update', statusIdRequestId)
    },
}