<template>
  <div>
      <rent-payment-form></rent-payment-form>
  </div>
</template>

<script>

    import RentPaymentForm from '../components/RentPaymentForm.vue'
    
    export default {
        name: 'Renter',
        components: 
        {
            RentPaymentForm
        },
    
    }

</script>

<style>

</style>