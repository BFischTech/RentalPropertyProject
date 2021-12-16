<template>
  <div>
    <b-alert variant="danger" class="text-center" show>There are {{ pendingRequest.length }} pending tickets!</b-alert>
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
          <div>Unit Building Number: {{ request.unitBuildingNumber }}</div>
          <div>Unit Number: {{ request.unitNumber }}</div>
          <div>Adresss: {{ request.unitAdresss }}</div>
          <div>Type: {{ request.requestType }}</div>
          <div>Concern: {{ request.concern }}</div>
          <div>Request Date Time: {{ request.dateTimeRequestMade }}</div>
          <div>employeeeAssigned: {{ request.EmployeeeAssigned }}</div>
          <div>Request Status: {{ request.requestStatus }}</div>
          <div>
            <b-button-group class="mt-3">
              <b-button>Save</b-button>
              <b-dropdown right text="Change Status">
                <b-dropdown-item>Completed</b-dropdown-item>
                <b-dropdown-item>Cancelled</b-dropdown-item>
                
              </b-dropdown>
            </b-button-group>
          </div>
        </b-card-text>
      </b-card>
    </div>
    <b-alert variant="success" class="text-center" show>There are {{ resolvedRequest.length }} pending tickets!</b-alert>
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
          <div>Unit Building Number: {{ request.unitBuildingNumber }}</div>
          <div>Unit Number: {{ request.unitNumber }}</div>
          <div>Adresss: {{ request.unitAdresss }}</div>
          <div>Type: {{ request.requestType }}</div>
          <div>Concern: {{ request.concern }}</div>
          <div>Request Date Time: {{ request.dateTimeRequestMade }}</div>
          <div>Employeee Assigned: {{ request.EmployeeeAssigned }}</div>
          <div>Request Status: {{ request.requestStatus }}</div>
        </b-card-text>
      </b-card>
    </div>
  </div>
</template>

<script>

import LandlordService from "../services/LandlordService.js";

export default {
  name: "maintenanceowner",
  data() {
    return { maintenanceRequests: [] };
  },
  created() {
    LandlordService.getMaintenanceForOwner().then((response) => {
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

<style>
</style>