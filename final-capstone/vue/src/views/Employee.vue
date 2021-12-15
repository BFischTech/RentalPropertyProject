<template>
  <div>
    <div
      id="employee"
      v-for="request in maintenanceRequests"
      :key="request.maintenanceRequestId"
    >
      <b-card
        :title="'Ticket #' + request.maintenanceRequestId"
        :sub-title="'Requested ' + request.dateTimeRequestMade"
        class="text-left"
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
};
</script>

<style>
</style>