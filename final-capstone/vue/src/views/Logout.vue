<template>
  <h1>
  MashedPotatoes</h1>
   
</template>

<script>


export default {
  

  created() {
    this.$store.commit("LOGOUT");
    this.$router.push("/");
  }
};
</script>
