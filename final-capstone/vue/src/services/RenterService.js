import axios from 'axios';

export default {
    
 createMaintenanceRequest(request) {
    return axios.post('/MaintenanceRequest', request);
  }
};
