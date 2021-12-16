<template>
  <div class="container" id="div-container">
    <header><h3>Assign Tenant To Available Unit</h3></header>
    <landlord-add-renter-to-unit></landlord-add-renter-to-unit>
    <div id="div-table">
      <h2>Unit Available</h2>
      <b-table-simple responsive>
        <b-thead>
          <b-tr>
            <b-th>Unit id</b-th>
            <b-th>Type</b-th>
          </b-tr>
        </b-thead>
        <b-tbody>
          <b-tr v-for="unit in unitAndTenants.unit" :key="unit.unitId">
            <b-td>{{ unit.unitId }}</b-td>
            <b-td>{{ unit.unitType }}</b-td>
          </b-tr>
        </b-tbody>
      </b-table-simple>
    </div>
    <br>
    <div id="div-table">
      <h2>Tenant Available</h2>
      <b-table-simple responsive>
        <b-thead>
          <b-tr>
            <b-th>Tenant id</b-th>
            <b-th>Name</b-th>
            <b-th>Email</b-th>
            <b-th>Mobile No.</b-th>
          </b-tr>
        </b-thead>
        <b-tbody>
          <b-tr v-for="tenant in unitAndTenants.tenant" :key="tenant.tenantId">
            <b-td>{{ tenant.tenantId }}</b-td>
            <b-td>{{ tenant.lastName }}, {{ tenant.firstName }}</b-td>
            <b-td>{{ tenant.email }}</b-td>
            <b-td>{{ tenant.mobileNumber }}</b-td>
          </b-tr>
        </b-tbody>
      </b-table-simple>
    </div> 
  </div>
</template>

<script>
import LandlordService from "../services/LandlordService.js";
import LandlordAddRenterToUnit from '../components/LandlordAddRenterToUnit.vue'

export default {
  components: { 
    LandlordAddRenterToUnit 
  },
  data() {
    return {
      unitAndTenants: [],
    }
  },
  created() {
    LandlordService.GetAllAvailableUnitsByOwnerAndTenantWithoutRentedUnit().then(response => {
      this.unitAndTenants = response.data;
    });
  },
}
</script>

<style scoped>
@import url(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css);

header {
  width: 100%;
  height: 5rem;
  background-color: green;
  display: flex;
  justify-content: center;
  align-items: center;
}

#div-container {
  margin: 2rem auto;
  max-width: auto;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
  padding:  1rem;
  text-align: center;
}

#div-table {
  margin: 2rem auto;
  max-width: auto;
  border-radius: 12px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.26);
  padding:  1rem;
  text-align: center;
}
</style>