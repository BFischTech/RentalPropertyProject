<template>
  <div>
    <b-card bg-variant="light">
      <p id="submitFormHeading">Submit Rent Form</p>
      <b-form @submit="onSubmit" @reset="onReset" v-if="show">
        <b-form-group id="rentPaymentFormGroup">
          <p id="inputPaymentDate">Choose a payment date</p>
          <b-form-datepicker
            label
            for="datepicker"
            id="inputDatepicker"
            v-model="date"
            class="datepicker"
          ></b-form-datepicker>
          <!-- <p>Date Chosen: {{ value }}</p> -->

          <p id="propertyToChoose">Choose a property</p>
          <b-form-select
            id="inputPropertySelect"
            v-model="form.property"
            :options="properties"
            required
          ></b-form-select>

          <p id="rentAmount">Enter payment amount</p>
          <b-form-input
            id="inputRent"
            v-model="form.rent"
            type="number"
            pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$"
            value=""
            data-type="currency"
            placeholder="$1.00"
            required
          >
          </b-form-input>

          <b-form-checkbox-group v-model="form.checked" id="inputCheckbox">
            <b-form-checkbox value="agree"
              >&nbsp; I agree to the terms and conditions</b-form-checkbox
            >
          </b-form-checkbox-group>
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
export default {
  data() {
    return {
      form: {
        date: "",
        property: null,
        checked: [],
      },
      properties: [
        { text: "Select One", value: null },
        "Example Property 1",
        "Example Property 2",
        "Example Property 3",
        "Example Property 4",
      ],
      show: true,
      date: "",
    };
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();
      alert(JSON.stringify(this.form));
    },
    onReset(event) {
      event.preventDefault();
      // Reset our form values
      this.form.date = "";
      this.form.property = null;
      this.form.checked = [];
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    },
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