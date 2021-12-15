<template>
  <div id="container-grid">

    <div>
      <b-carousel
        id="carousel-fade"
        style="text-shadow: 0px 0px 2px #000"
        fade
        indicators
      >
        <b-carousel-slide id="image" v-for="unitImage in units.image" :key="unitImage.imageId"
          :caption="unitImage.imageCaption"
          :img-src="unitImage.imageUrl"
        ></b-carousel-slide>
      </b-carousel>
    </div>

    <div id="unit" v-for="unit in units.unit" :key="unit.unitId">
      <b-card :title="'Available Unit'" :sub-title="'Rent is $' + unit.rentAmount + ' a month'" class="text-center"> 
        <b-card-text>Bedroom Count {{ unit.bedroomCount }} <br>
          Bathroom Count {{ unit.bathroomCount }} <br>
          Is Pet Friendly {{ unit.petFriendly }}  <br>
          Allows Smoking? {{ unit.nonSmoking }} <br>
          Has a Pool? {{ unit.poolAccess }}  <br>
          Parking Spots?{{ unit.parkingSpots }}  <br>
          Rent Amount: {{ unit.rentAmount }} <br>
          Rent Due Date: {{ unit.rentDueDate }} <br>
        </b-card-text>
      </b-card>
    </div>

  </div>
</template>

<script>
import PropertyService from "../services/PropertyService.js";

export default {
  name: "unitPage",
  data() {
    return {
      units: [],
    }
  },
  created() {
    PropertyService.getAllUnitsById(this.$route.params.id).then(response => {
      this.units = response.data;
    });
  },
}

</script>

<style scoped>
  #image {
    width: 30rem;
    height: 20rem;
  }

@import url(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css);


@media (min-width: 801px) {
  img {
    width: 30rem;
    height: 20rem;
  }

  

  #container-grid {
    display: flex;
    flex-direction: row;
    row-gap: 5px;
    column-gap: 5px;
    justify-content: space-evenly;
  }
  
  }

  #unit {
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
  }




@madia (max-width:800px) {
  img {
    width: 35rem;
    height: 20rem;
  }

  #container-grid {
    display: flex;
    flex-direction: row;
    row-gap: 5px;
    column-gap: 5px;
    justify-content: space-evenly;
  }

}

#unit {
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
}




</style>