<template>
  <div class="the-header">THIS IS OUR HEADER
    <router-link to="/">Home</router-link>
    <router-link to="/login">Login</router-link>
    <router-link to="/logout">Logout</router-link>
    <router-link to="/register">Register</router-link>
  </div>
</template>

<script>
export default {
  name: "the-header",
};
</script>


<style scoped>





.the-header {
  grid-area: the-header;
  background-color: #80B969;
  font-size: 5rem;
}

.container {
  display: grid;
  grid-template-areas: "the-header the-header the-header";
  grid-template-columns: 200px 1fr 200px;
  gap: 10px;
  
}

@media screen and (max-width: 1024px) {
  .container {
    grid-template-areas: "the-header the-header";
    grid-template-columns: 1fr 1fr;
  }
}

@media screen and (max-width: 768px) {
  .container {
    grid-template-areas: "the-header";
    grid-template-columns: 1fr;
  }
}
</style>