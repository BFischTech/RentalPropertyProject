import axios from 'axios';

export default {
    
 createMaintenanceRequest(request) {
    return axios.post('/MaintenanceRequest', request);
  },
  
  addNewPayment(payment) {
    return axios.post('/tenant', payment);
  }

};
