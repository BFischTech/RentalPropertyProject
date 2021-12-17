<template>
  <div style="background-color: #80B969">
      <header><h1>Owner Portal</h1></header><br>
        <b-button id="form" @click="goToAddPropertyPage()">Add New Property</b-button> <br>
        <b-button id="form" @click="goToAddUnitPage()">Add New Unit</b-button><br>
        <b-button id="form" @click="goToAddRenterToUnit()">Add Renter to Available Unit!</b-button><br>
        <b-button id="form" @click="goToMaintenanceRequestsPage()">View Maintenance Requests</b-button><br>
        <b-button id="form" @click="goToAddUnitPage()">Update a Property</b-button><br>
  </div>
</template>


<script>
export default {
  name: "NewListingForm",
  methods: {
    goToAddPropertyPage() {
      this.$router.push("/newpropertylisting");
    },
    goToAddUnitPage() {
      this.$router.push("/newunitlisting");
    },
    goToAddRenterToUnit() {
      this.$router.push("owner/addRenterToUnit");
    },
    goToMaintenanceRequestsPage() {
      this.$router.push("/MaintenanceRequest/owner");
    },
  },
};
</script>

<style scoped>


header {
  width: 100%;
  height: 5rem;
  background-color: #80B969;
  display: flex;
  justify-content: center;
  align-items: center;
}
div {
  margin: 2rem auto;
  max-width: 30rem;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.26);
  padding:  1rem;
  text-align: center;
}

button {
  display: block;
  width: 100%;
  border: none;
  background-color: #3B4954;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
  text-align: center;
}

button:hover {
  background-color: green;
}
</style>