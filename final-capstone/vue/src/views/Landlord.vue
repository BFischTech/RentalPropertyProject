<template>
 <div class="container">
   <ul>
     <li><router-link :to="{ name: 'newpropertylisting'}">Enter a New Property Listing</router-link></li>
     <li><router-link :to="{ name: 'newpropertylisting'}">Enter a New Unit Listing</router-link></li>
    <li><router-link :to="{ name: 'addRenterToUnit'}">Add Renter to Available Unit!</router-link></li>
   </ul>
 </div>
</template>


<script>



export default {
  
name: 'NewListing',

}
</script>

<style>

</style>