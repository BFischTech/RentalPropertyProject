<template>
  <div id="container-grid">
    <div style="background-color: #212529" id="property" v-for="property in properties" :key="property.propertyId">
      <b-card  style="border-color: #212529" :header="property.propertyType" :title="property.name" :img-src="property.imageUrl"
              :sub-title="'$'+property.rentAmount + ' monthly'" img-alt="Image" img-top tag="article" class="mb-2">
        <b-card-text>
          "{{ property.description.substring(0, 60) + '...' }}"
          <br>
          {{ property.city }}, {{ property.state }}, {{ property.zipCode }}
        </b-card-text>
        <i class="fa fa-bed" aria-hidden="true"> {{ property.bedroomCount }} Bedroom&#40;s&#41;</i>
        <i class="fa fa-shower" aria-hidden="true">{{ property.bathroomCount }} Bathroom&#40;s&#41;</i>

        <div>
          
          <p v-if="property.availableUnits >= 1 && property.propertyType !== 'House'">{{ property.availableUnits }} -
            Available Unit&#40;s&#41;</p>
          <p v-if="property.availableUnits >= 1 && property.propertyType === 'House'">Available To Rent</p>
        </div>
        <!-- <b-button href="#" variant="primary"  >View Details</b-button> -->
        <!--*SHIT <button @click="$router.push('../src/property')">View Details</button> -->
        <router-link :to="{ name: 'unitPage', params: { id: property.propertyId }}">View Details</router-link>
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





  img {
    width: 30rem;
    height: 20rem;
  }

  #container-grid {
    display: flex;
    flex-wrap: wrap;
    row-gap: 5px;
    column-gap: 5px;
    justify-content: space-evenly;
    justify-items: center;
    background-color: #80B969;
    padding-top: 30px;
  }

  #property {
    margin: 2rem auto;
    display: flex;
    align-items: center;
    border-radius: .3rem;
    border-style: solid;
    border-color: #212529;
    padding:  .7rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.26)
  }

  #container {
    background-color:#c0ddb5;
    width: 35rem;
    padding: 20px;
  }




</style>