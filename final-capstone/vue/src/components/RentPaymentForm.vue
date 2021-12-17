<template>
  <div id="container">
    <b-form-group>
    <b-card bg-variant="light">
      <b-form @submit.prevent="onSubmit" @reset="onReset" v-if="show">
        
        <p>Thank you for your payment!</p>
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
          ></b-form-input>
       

        <b-button type="submit" variant="primary">Submit</b-button>
        <b-button type="reset" variant="danger">Reset</b-button>
      </b-form>
    </b-card>
    </b-form-group>
  </div>
</template>

<script>
import renterService from '../services/RenterService.js'

export default {
  data() {
    return {
      tenant: {
        amount: '',
        tenantId: null,
      },

      show: true,
    }
  },
  methods: {
    onSubmit() {
      const newRentPayment = {
        amount: parseInt(this.tenant.amount),
        tenantId: this.$store.state.user.userId,
      }

      renterService
        .addNewPayment(newRentPayment)
        .then((response) => {
          if (response.status === 204) {
            this.$router.push(`/`)
          }
        })
        .catch((error) => {
          console.log(error)
        })
    },

    onReset(event) {
      event.preventDefault()
      // Reset our form values
      this.tenant.amount = ''
      this.tenant.tenantId = null
      // Trick to reset/clear native browser form validation state
      this.show = false
      this.$nextTick(() => {
        this.show = true
      })
    },
  },
}
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
  padding: 25px 0px 0px 0px;
}

#inputCheckbox {
  padding: 50px 0px 0px 0px;
}

.buttons {
  padding: 50px 0px 0px 0px;
}
</style>
