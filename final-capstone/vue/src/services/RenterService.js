import axios from 'axios';

export default {
    
 createMaintenanceRequest(request) {
    return axios.put('/MaintenanceRequest', request);
  }
};
