<template>
  <div>
    <b-card bg-variant="light">
      <p id="submitFormHeading">Submit Rent Form</p>
      <b-form @submit="onSubmit" @reset="onReset" v-if="show">
        <b-form-group id="rentPaymentFormGroup">
      

       

          <p id="rentAmount">Enter payment amount</p>
          <b-form-input
            id="inputRent"
            v-model="tenant.amount"
            type="number"
            pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$"
            value=""
            data-type="currency"
            placeholder="$1.00"
            required
          >
          </b-form-input>

         
        </b-form-group>
        
        <b-form-group class="buttons">
          <b-button class="submitButton" type="submit" variant="primary"
            >Submit</b-button
          >
          <b-button class="resetButton" type="reset" variant="danger"
            >Reset</b-button
          >
        </b-form-group>
      </b-form>
    </b-card>
  </div>
</template>

<script>
import RenterService from "../services/RenterService.js";

export default {
  data() {
    return {
      tenant: {
        amount: 0,
      },
      
      show: true,
      
    };
  },
  methods: {
    onSubmit() {
     const newRentPayment = {
        amount: this.tenant.amount,
      };
RenterService.addNewPayment(newRentPayment)
      .then((response) => {
        if (response === 204 ){this.$router.push(`/tenant`);}
        })
          .catch((error) => {
            this.handleErrorResponse(error, "adding");
          });
    },

     
    },
    onReset(event) {
      event.preventDefault();
      // Reset our form values
      this.tenant.amount = "";
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    },
};
</script>

<style scoped>
#submitFormHeading {
  text-align: center;
  font-size: 2rem;
  text-transform: uppercase;
}

#propertyToChoose {
  padding: 50px 0px 0px 0px;
}

#rentAmount {
  padding: 50px 0px 0px 0px;
}

#inputCheckbox {
  padding: 50px 0px 0px 0px;
}

.buttons {
  padding: 50px 0px 0px 0px;
}
</style>