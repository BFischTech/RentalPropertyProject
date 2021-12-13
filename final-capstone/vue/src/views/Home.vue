<template>
  <div class="home">
    <div class="property" v-for="property in properties" :key="property.propertyId">
      {{ property.propertyType }}

      <b-card  :title="property.name" :img-src="property.imageUrl" :sub-title="property.description" img-alt="Image" img-top tag="article" class="mb-2">

        <b-card-text >
          {{ property.city }}, {{ property.state }}, {{property.zipCode}}
        </b-card-text>
        <div>
          <router-link>
            <b-button href="#" variant="primary">View Details</b-button>
          </router-link>
          
        </div>
          
          <b-button href="#" variant="primary">{{property.availableUnits}}Available Units</b-button>
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
  width: 35rem;
  height: 35rem;
}
body {
    margin: 0;
}

.home {
  
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    margin: 2em auto;
  
}

.property {
  border: 5px solid white ;

}

header {
    grid-area: header;
    background-color: #F69A00;
}
nav {
    grid-area: nav;
    margin-left: 0.5rem;
    background-color: #F2EAD2;
}
main {
    grid-area: content;
    background-color: #F9F5F0;
}
aside {
    grid-area: side;
    margin-right: 0.5rem;
    background-color: #F2EAD2;
}
footer {
    grid-area: footer;
    background-color: #331312;
}
header, footer {
    color: #FFFFFF;
}
nav, main, aside {
    color: #74889A;
}
header, footer, nav, main, aside {
    font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 24px;
    text-transform: uppercase;
}
div.content {
    text-align: center;
    padding-top: 20px;
}
/*if screen size is less than 769*/
@media (max-width: 768px) {
    .container {
        grid-template-areas:
            "header"
            "nav"
            "content"
            "side"
            "footer";
        grid-template-columns: 1fr;
        grid-template-rows:
            auto /* Header */
            75px /* Nav */
            1fr /* Content */
            75px /* Sidebar */
            auto; /* Footer */
    }
    header, footer, nav, main, aside {
        padding: 5px 0;
    }
    nav, aside {
      margin: 0;
    }
}
 
</style>