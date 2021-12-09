<template>
  <div class="home">
    <the-header></the-header>
    <h1>Home</h1>
    <p>You must be authenticated to see this</p>
  </div>
</template>

<script>

import TheHeader from "../components/TheHeader.vue";

export default {
  name: "home",
  components: {
    TheHeader
  }
};
</script>
