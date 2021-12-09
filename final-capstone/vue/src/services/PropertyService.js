import axios from 'axios';

export default {

    getAllProperties() {
        return axios.get('/properties')
    }
}