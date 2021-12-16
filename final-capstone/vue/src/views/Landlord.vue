<template>
  <div>
    <div id="container-grid">
      <h1 id="header">Owner Portal</h1>
      <div>
        <b-button
          id="form"
          
          @click="goToAddPropertyPage()"
          >Add New Property</b-button
        >
      </div>

      <div>
        <b-button
          id="form"
          
          @click="goToAddUnitPage()"
          >Add New Unit</b-button
        >
      </div>

      <div>
        <b-button
          id="form"
          
          @click="goToAddUnitPage()"
          >Add New Tenant to Property</b-button
        >
      </div>

      <div>
        <b-button
          id="form"
          
          @click="goToAddUnitPage()"
          >View Maintenance Requests</b-button
        >
      </div>

      <div>
        <b-button
          id="form"
          
          @click="goToAddUnitPage()"
          >Update a Property</b-button
        >
      </div>
    </div>
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
  },
};
</script>



<style scoped>
#container-grid {
  display: grid;
  grid-template-columns: 50% 25% 25%;
  row-gap: 5px;
  column-gap: 5px;
  padding-left: 15px;
  justify-content: space-evenly;
  justify-items: center;
  align-content: space-evenly;
  align-items: center;
}
</style>