<template>
  <b-container class="bv-example-row">
    <b-row>
      <b-col align-self="center">
        <b-button id="form" v-b-modal.rent-modal>New Rental Payment</b-button>
        <b-modal id="rent-modal">
          <template #modal-footer="{cancel }">
            <b-button size="sm" variant="danger" @click="cancel()">
              Cancel
            </b-button>
          </template>
          <rent-payment-form></rent-payment-form>
        </b-modal>
        <br />
      </b-col>

      <b-col align-self="center">
        <h2>Welcome to the tenant portal, how may we help you?</h2>
      </b-col>

      <b-col align-self="center">
        <b-button id="form" v-b-modal.maintenance-modal>
          New Maintenance Request
        </b-button>
        <b-modal id="maintenance-modal">
          <template #modal-footer="{cancel }">
            <b-button size="sm" variant="danger" @click="cancel()">
              Cancel
            </b-button>
          </template>
          <maintenance-form></maintenance-form>
        </b-modal>
      </b-col>
    </b-row>

    <b-row>
      <b-col>Previous Transactions - placeholder)</b-col>
      <b-col></b-col>
      <b-col>Pending maintenance request(s) - placeholder</b-col>
    </b-row>
  </b-container>
</template>

<script>
import RentPaymentForm from '../components/RentPaymentForm.vue'
import MaintenanceForm from '../components/MaintenanceForm.vue'
import RenterService from '../services/RenterService.js'

export default {
  name: 'Renter',
  components: {
    RentPaymentForm,
    MaintenanceForm,
  },
  methods: {
    createMaintenanceRequest() {
      RenterService.createMaintenanceRequest(this.MaintenanceForm)
    },
  },
}
</script>

<style scoped>
.bv-example-row {
  margin: auto;
  width: 50%;
  padding: 20px;
  border-radius: 12px;
  border-style: solid;
  border-color: 212529;
  background-color: #80b969;
}
</style>
