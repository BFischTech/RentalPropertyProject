<template>
  <div id="container">
    <b-form @submit.prevent="onSubmit" @reset="onReset" v-if="show">
      <p>We apologize for the trouble you are having.  Please fill out the form below and we'll get right on it!</p>
      <b-form-group id="input-group-3" label="What seems to be the problem?" label-for="input-3">
        <b-form-select
            id="input-3"
            v-model="form.requestTypeId"
            :options="maintenanceTypes"
            required
        ></b-form-select>
      </b-form-group> <br>
      <b-row class="mt-2">
        <b-col sm="2">
          <label>Concern:</label>
        </b-col>
        <b-col sm="10">
          <b-form-textarea
              v-model="form.concern"
              id="textarea-concern"
              placeholder="please describe the problem"
          ></b-form-textarea>
        </b-col>
      </b-row>
       <br>
      <b-button type="submit" variant="primary">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
  </div>
</template>

<script>

import renterService from "../services/RenterService";

export default {
  name: "",
  props: {
    maintenanceRequestId: {
      type: Number,
      default: 0,
    },
    requestDateTime: {
      type: String,
      default: "",
    },
    employeeAssignedId: {
      type: Number,
      default: null,
    },
  },
  data() {
    return {
      form: {
        requestTypeId: null,
        concern: null,
        tenantId: null,
        requestStatusId: 0,
      },
      maintenanceTypes: [{text: 'Select One', value: null}, {text: 'Electrical', value: 1}, {
        text: 'Fences',
        value: 2
      }, {text: 'Painting', value: 3}, {text: 'Plumbing', value: 4}, {text: 'Drywall', value: 5}, {
        text: 'Others',
        value: 6
      }],
    
  
    show: true
  }
  },
  methods: {
    onSubmit() {
      
      const formData = {
          requestTypeId: this.form.requestTypeId,
          concern: this.form.concern,
          tenantId: this.tenantId,
          requestStatusId: this.requestStatusId
      };
      
    renterService
    .createMaintenanceRequest(formData)
        .then((response) => {
          if (response.status === 204) {
            this.$router.push(`/`);
          }
        })
        .catch((error) => {
          console.log(error);
        });

  },
    
    onReset(event) {
      event.preventDefault()
      // Reset our form values
      this.form.requestTypeId = null
      this.form.concern = null
    
      // Trick to reset/clear native browser form validation state
      this.show = false
      this.$nextTick(() => {
        this.show = true
      })
    }
  }
}
</script>

<style scoped>

#container {
  display: flex;
  flex-direction: column;
  margin: auto;
  justify-content: space-evenly;
}

</style>