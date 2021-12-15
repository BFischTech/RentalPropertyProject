import axios from 'axios';

export default {
    
 createMaintenanceRequest(formData) {
    return axios.put(/maintenance-requests/, formData);
  }
};
