<template>
  <div class="container">
    <div class="container">
<div>
  <b-form >
    <label class="mr-sm-2" for="inline-form-custom-select-pref">Preference</label>
    <b-form-select
      id="inline-form-custom-select-pref"
      class="mb-2 mr-sm-2 mb-sm-0"
      :options="[{ text: 'Choose...', value: null }, 'One', 'Two', 'Three']"
      :value="null"
    ></b-form-select>

    <b-form-checkbox class="mb-2 mr-sm-2 mb-sm-0">Remember my preference</b-form-checkbox>

    <b-button variant="primary">Save</b-button>
  </b-form>
</div>
    </div>

    <div id="unitAvailable">
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
    <div id="tenantAvailable">
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

export default {
  data() {
    return {
      unitId: null,
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
</style>