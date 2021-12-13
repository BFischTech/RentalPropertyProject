<template>
  <main>
    <div>
      <router-link
       v-bind:to="{ name: 'Property', params: { id: $route.params.propertyID } }"
      >
      </router-link>
      <h1>
        {{ property.address }}
      </h1>
      <p>
        {{ property.description }}
      </p>
      
    </div>
  </main>
</template>

<script>
import propertyService from "../services/PropertyService";

export default {
  name: "property-detail",
  components: {
    
  },
  data() {
    return {
      property: {
        address: "",
        description: "",
      },
    };
  },
  created() {
    const propertyID = this.$route.params.propertyID;
    const unitID = this.$route.params.unitID;

    propertyService.getAllUnits().then((response) => {
      this.unit = response;

    });
  },
};
</script>
