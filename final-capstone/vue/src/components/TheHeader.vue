<template>
  <div class="the-header">test</div>
</template>

<script>
export default {
  name: "the-header",
};
</script>


<style scoped>
.the-header {
  grid-area: header;
  background-color: #f69a00;
}

.container {
  display: grid;
  grid-template-areas: "the-header the-header the-header";
  grid-template-columns: 200px 1fr 200px;
  gap: 10px;
  
}

@media screen and (max-width: 1024px) {
  .container {
    grid-template-areas: "header header";
    grid-template-columns: 1fr 1fr;
  }
}

@media screen and (max-width: 768px) {
  .container {
    grid-template-areas: "header";
    grid-template-columns: 1fr;
  }
}
</style>