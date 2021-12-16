<template>
  <div id="container-grid">
    <div id="divContainer">
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
    <div v-for="unit in units.unit" :key="unit.unitId">
      <b-card :title="unit.name" sub-title="(Available)" class="text-center"> 
        <b-card-text>
          <i>'Rent is &dollar;{{unit.rentAmount}} a month'</i><br><br>
            <h5>&#8220;{{ unit.description }}&#8221;</h5>
            <i class="fa fa-bed" aria-hidden="true"> {{ unit.bedroomCount }} Bedroom&#40;s&#41;</i> &nbsp;
            <i class="fa fa-shower" aria-hidden="true">{{ unit.bathroomCount }} Bathroom&#40;s&#41;</i> <br>
            <i class="fa fa-paw" aria-hidden="true" v-if="unit.petFriendly === true"> Pets allowed</i>
            <i class="fa fa-paw" aria-hidden="true" v-else>No pets allowed</i><br>
            <i v-if="unit.nonSmoking === true">Smoking allowed<br></i>
            <i v-else>No smoking allowed<br></i>
            <i v-if="unit.poolAccess === true">Has a pool<br></i> 
            <i class="fa fa-car" aria-hidden="true">{{ unit.parkingSpots }} Parking spot&#40;s&#41;</i>
        </b-card-text>
      </b-card>
    </div>
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
#divContainer {
  margin: 2rem auto;
  max-width: 30rem;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.26);
  padding:  1rem;
  text-align: center;
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