<template>
  <div id="container-grid">
    <div id="property" v-for="property in properties" :key="property.propertyId">
      <b-card :header="property.propertyType" :title="property.name" :img-src="property.imageUrl" :sub-title="property.description.substring(0,60)+'...'" img-alt="Image" img-top tag="article" class="mb-2">
        <b-card-text >
          {{ property.city }}, {{ property.state }}, {{property.zipCode}}
        </b-card-text>
        <i class="fa fa-bed" aria-hidden="true"> {{property.bedroomCount}} Bedroom&#40;s&#41;</i>
        <i class="fa fa-shower" aria-hidden="true">{{property.bathroomCount}} Bathroom&#40;s&#41;</i>

        <div>
          <router-link>
            <b-button href="#" variant="primary">View Details</b-button>
          </router-link>
        <p v-if="property.availableUnits >= 1 && property.propertyType !== 'House'">{{property.availableUnits}} - Available Unit&#40;s&#41;</p>
        <p v-if="property.availableUnits >= 1 && property.propertyType === 'House'">Available To Rent</p>
        </div>
          <b-button href="#" variant="primary">View Details</b-button>

      </b-card>
    
      
    </div>
  </div>
</template>


<script>
import PropertyService from "../services/PropertyService.js";
export default {
  name: "home",
    data() {
      return {
        properties: [],
      }
    },
    created() {
      PropertyService.getAllProperties().then(response => {
        this.properties = response.data;
    });
  },
}

</script>

<style scoped>
@import url(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css);


@media (min-width:801px) {
img {
  width: 30rem;
  height: 20rem;
}

#container-grid {
  display: grid;
  grid-template: 1fr 1fr 1fr;
  row-gap: 5px;
  column-gap: 5px;
  grid-template-areas: 
    "property property property";
  justify-content: space-evenly;
  justify-items: center;
  align-content: space-evenly;
  align-items: center;
}

#property {
  display: flex;
  align-items: center;
}

#container {
  background-color: white;
  width: 35rem;
  padding: 20px;
}
}

@madia (max-width:800px) {
img {
  width: 35rem;
  height: 20rem;
}
#container-grid {
  display: grid;
  grid-template: 1fr 1fr;
  row-gap: 5px;
  column-gap: 5px;
  grid-template-areas: 
    "property property";
  justify-content: space-evenly;
  justify-items: center;
  align-content: space-evenly;
  align-items: center;
}

#property {
  display: flex;
  align-items: center;
}

#container {
  background-color: white;
  width: 35rem;
  padding: 20px;
}
}

</style>