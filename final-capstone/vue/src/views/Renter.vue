<template>
  <div id="container-grid"><h1 id="header">Welcome to the tenant portal, how may we help you?</h1>
  <h2 id="greeting">Please don't hesitate to <a href="/contact">contact us</a>!</h2>
  <div>
    <b-button id="form" v-b-modal.form-modal>Rental Payment</b-button>
      <b-modal id="form-modal"><rent-payment-form></rent-payment-form></b-modal>
  </div></div>
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

<style scoped>

#container-grid {
  display: grid;
  grid-template-columns: 30% 40% 30%;
 
  row-gap: 5px;
  column-gap: 5px;
 
   padding-left: 15px;
  justify-content: space-evenly;
  justify-items: center;
  align-content: space-evenly;
  align-items: center;
}




</style>