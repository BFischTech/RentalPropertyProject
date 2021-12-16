<template>
<div>
  <h1>Enter New Unit Details</h1>
  <new-listing-for-unit-form>
  </new-listing-for-unit-form>
</div>
  
</template>

<script>

import NewListingForUnitForm from '../components/NewListingForUnitForm.vue'

export default {
  components: { NewListingForUnitForm },
name: 'NewListingForUnit',

}
</script>

<style scoped>
h1{
  text-align: center;
}
</style>