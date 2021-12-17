<template>
  <div class="container" >
    
    <b-alert variant="danger" class="text-center" show>You have {{ pendingRequest.length }} pending tickets!</b-alert>
    <div
      id="pending"
      v-for="request in pendingRequest"
      :key="request.maintenanceRequestId"
    >
      <b-card
        :title="'Ticket #' + request.maintenanceRequestId"
        :sub-title="'Requested ' + request.dateTimeRequestMade"
        class="text-left"
        border-variant="danger"
        header="Pending"
        header-border-variant="danger"
        header-text-variant="danger"
      >
        <b-card-text>
          <div>Property ID: {{ request.propertyId }}</div>
          <div>Unit Type: {{ request.unitType }}</div>
          <div>Tenant: {{ request.fromTenant }}</div>
          <div>Unit Number: {{ request.unitNumber }}</div>
          <div>Adresss: {{ request.unitAdresss }}</div>
          <div>Type: {{ request.requestType }}</div>
          <div>Concern: {{ request.concern }}</div>
          <div>Request Date Time: {{ request.dateTimeRequestMade }}</div>
          <div>employeeeAssigned: {{ request.employeeeAssigned }}</div>
          <div>Request Status: {{ request.requestStatus }}</div>
          <div>
            <b-button-group class="mt-3">
              <b-button>Save</b-button>
              <select v-model="request.requestStatus">
                  <option value="" selected disabled>Change Status Here</option>
                  <option>Completed</option>
                  <option>Cancelled</option>
                </select>
            </b-button-group>
          </div>
        </b-card-text>
      </b-card>
    </div>
    <b-alert variant="success" class="text-center" show>You have {{ resolvedRequest.length }} resolved tickets!</b-alert>
    <div
      id="resolved"
      v-for="request in resolvedRequest"
      :key="request.maintenanceRequestId"
    >
      <b-card

        :title="'Ticket #' + request.maintenanceRequestId"
        :sub-title="'Requested ' + request.dateTimeRequestMade"
        class="text-left"
        border-variant="success"
        header="Resolved"
        header-border-variant="success"
        header-text-variant="success"
      >
        <b-card-text>
          <div>Property ID: {{ request.propertyId }}</div>
          <div>Unit Type: {{ request.unitType }}</div>
          <div>Tenant: {{ request.fromTenant }}</div>
          <div>Unit Number: {{ request.unitNumber }}</div>
          <div>Adresss: {{ request.unitAdresss }}</div>
          <div>Type: {{ request.requestType }}</div>
          <div>Concern: {{ request.concern }}</div>
          <div>Request Date Time: {{ request.dateTimeRequestMade }}</div>
          <div>employeeeAssigned: {{ request.employeeeAssigned }}</div>
          <div>Request Status: {{ request.requestStatus }}</div>
        </b-card-text>
      </b-card>
    </div>
  </div>
</template>

<script>
import EmployeeService from "../services/EmployeeService.js";

export default {
  name: "employee",
  data() {
    return { maintenanceRequests: [] };
    
  },
  created() {
    EmployeeService.getMaintenanceByID().then((response) => {
      this.maintenanceRequests = response.data;
    });
  },

  computed: {
    pendingRequest: function () {
      return this.maintenanceRequests.filter(
        (x) => x.requestStatus == "Pending"
      );
    },
    resolvedRequest: function () {
      return this.maintenanceRequests.filter(
        (x) => x.requestStatus !== "Pending"
      );
    },
  },

};
</script>

<style scoped>

.card-body {
 background-color: #c0ddb5
}

.container{
background-color: #80b969;}


</style>>
