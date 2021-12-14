<template>
  <div>
      <div id="unit" v-for="unit in units" :key="unit.unitId">
          {{unit.bedroomCount}}, {{unit.bathroomCount}}, {{unit.petFriendly}}
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

console.log("I'm Here!!")
</script>

<style >
@import url(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css);


@media (min-width: 801px) {
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