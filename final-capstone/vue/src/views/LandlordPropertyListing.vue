<template>
<div>
  <h1>Enter New Property Details</h1>
  <new-listing-form>
  </new-listing-form>
</div>
  
</template>

<script>

import NewListingForm from '../components/NewListingForm.vue'

export default {
  components: { NewListingForm },
name: 'NewListing',

}
</script>

<style scoped>
h1{
  text-align: center;
}
</style>