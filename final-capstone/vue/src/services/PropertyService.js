import axios from 'axios';

export default {

    getAllProperties() {
        return axios.get('/properties')
    },

    getAllUnits() {
        return axios.get('/units')
    },
    
    getUserRole() {
        return axios.get('/login')
    }
}