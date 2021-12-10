<template>
  <div class="home">
    <div v-for="property in properties" v-bind:key="property.propertyId">
      <h2><img :src="property.imageUrl" alt="pretty stuff"></h2>
      <h2>&#36;{{ property.rentAmount }}</h2>  
      <h2>{{ property.propertyName }}</h2>
      <h4>{{ property.city }}, {{ property.state }}</h4>
      <i class="fa fa-bed" aria-hidden="true"> {{ property.bedroomCount }} Bedrooms</i>
      <i class="fa fa-shower" aria-hidden="true"> {{ property.bathroomCount }} Bathrooms</i>
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
.container {
    display: grid;
    grid-template-areas:
        "header header header"
        "nav content side"
        "footer footer footer";
    grid-template-columns: 200px 1fr 200px;
    grid-template-rows: 125px 1fr 85px;
    gap: 10px;
    height: 100vh;
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