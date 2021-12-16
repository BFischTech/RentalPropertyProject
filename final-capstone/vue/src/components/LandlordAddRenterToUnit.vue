<template>
  <div class="container">
    <b-form @submit.prevent="onSubmit">
      <div id="divOption">
        <label for="">Select Unit Id:</label>&nbsp;
          <b-form-select v-model="unitAndTenant.unitId" required>
          <option value="" disabled>Unit Id</option>
          <option v-for="unit in unitAndTenants.unit" :value="unit.unitId" :key="unit.unitId">{{ unit.unitId }}</option>
        </b-form-select>
      </div>

      <div id="divOption">
          <label for="">Select Tenant Id: </label>&nbsp;
          <b-form-select v-model="unitAndTenant.tenantId" required>
          <option value="" disabled>Tenant Id</option>
          <option v-for="tenant in unitAndTenants.tenant" :value="tenant.tenantId" :key="tenant.tenantId">{{ tenant.tenantId }}</option>
        </b-form-select>
      </div>
      <b-button type="submit" variant="primary">Submit</b-button>
    </b-form>
  </div>
</template>


<script>
import LandlordService from "../services/LandlordService";

export default {
  data() {
    return {
      unitAndTenants: [],  
      unitAndTenant: {
        unitId: "",
        tenantId: ""    
      },
    };
  },
  created() {
    LandlordService.GetAllAvailableUnitsByOwnerAndTenantWithoutRentedUnit().then(response => {
      this.unitAndTenants = response.data;
    });
  },

  methods: {
    onSubmit() {
      const newUnitAndTenant = {
        unitId: this.unitAndTenant.unitId,
        tenantId: this.unitAndTenant.tenantId,
      };
      LandlordService.AssignTenantToUnit(newUnitAndTenant)
        .then((response) => {
          if (response.status === 204) {
            this.$router.put(`unit/owner/update`);
          }
        })
        .catch((error) => {
          this.handleErrorResponse(error, "updating");
        });

        this.$forceUpdate();
    },
  },

};
</script>

<style scoped>

#divOption {
  margin: 2rem auto;
  max-width: 30rem;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.26);
  padding:  1rem;
  text-align: center;
}

option{
  padding: 0.75rem 1.5rem;
  font-family: inherit;
  background-color: green;
  border: 1px solid green;
  color: white;
  cursor: pointer;
}
</style>