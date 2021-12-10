<template>
  <div class="home">
    <div v-for="property in properties" v-bind:key="property.id">
       <h2><img src="https://i.imgur.com/s9wmsrg.png" alt="pretty stuff"></h2>
      <h2>{{ property.address }}</h2>
      <h2>{{ property.city }}</h2>
      <h2>{{ property.state }}</h2>
      <h2>{{ property.zip }}</h2>
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