<template>
  <div class="container">
    <br />

    <b-card bg-variant="light">


      <b-form @submit.prevent="onSubmit" @reset="onReset">
        <b-form-group id="input-group-1">
          <b-form-select
          id="input-1"
          v-model="unit.types"
          :options="types"
          required
        ></b-form-select>

        <br/>

        <b-form-input
            id="input-2"
            v-model="unit.address"
            type="string"
            placeholder="Address"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-3"
            v-model="unit.city"
            type="string"
            placeholder="City"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-4"
            v-model="unit.state"
            type="string"
            placeholder="State"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-5"
            v-model="unit.zipCode"
            type="string"
            placeholder="Zip Code"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-6"
            v-model="unit.imgUrl"
            type="string"
            placeholder="Image URL"
          ></b-form-input>

          <br />

        <b-form-input
          id="input-7"
          v-model="unit.rentAmount"
          type="number"
            pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$"
            value=""
            data-type="currency"
            placeholder="$1.00"
            required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-8"
          v-model="unit.rentDueDate"
          type="number"
          placeholder="Rent Due Date"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-9"
          v-model="unit.buildingNumber"
          type="number"
          placeholder="Building Number"
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-10"
          v-model="unit.unitNumber"
          type="number"
          placeholder="Unit Number"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-11"
          v-model="unit.bedrooms"
          type="number"
          placeholder="Number of Bedrooms"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-12"
          v-model="unit.bathrooms"
          type="decimal"
          placeholder="Number of Bathrooms"
          required
        ></b-form-input>

        <br/>

        <p id="petsAllowed">Pets Allowed?</p>
        <b-form-select
          id="input-13"
          v-model="unit.pets"
          :options="pets"
          required
        ></b-form-select>

        <br/>

        <p id="smokingAllowed">Smoking Allowed?</p>
        <b-form-select
          id="input-14"
          v-model="unit.smoking"
          :options="smoking"
          required
        ></b-form-select>

        <br/>

        <p id="poolAccess">Pool?</p>
        <b-form-select
          id="input-15"
          v-model="unit.pool"
          :options="pool"
          required
        ></b-form-select>

        <br/>

        <b-form-input
          id="input-16"
          v-model="unit.parking"
          type="number"
          placeholder="Number of Parking Spots"
          required
        ></b-form-input>

        <br/>

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
import propertyService from "../services/PropertyService";

export default {
  name: "",
  props: {
    unitId: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      unit: {
        types: [
            {value: 'a', text: 'House'},
            {value: 'b', text: 'Condominium'},
            {value: 'c', text: 'Apartment'}
        ],
        address: "",
        city: "",
        state: "",
        zipCode: "",
        imgUrl: "",
        rentAmount: "",
        rentDueDate: "",
        buildingNumber: "",
        unitNumber: "",
        bedrooms: "",
        bathrooms: "",
        pets: [
            {value: 'a', text: 'Yes'},
            {value: 'b', text: 'No'},
        ],
        smoking: [
            {value: 'a', text: 'Yes'},
            {value: 'b', text: 'No'},
        ],
        pool: [
            {value: 'a', text: 'Yes'},
            {value: 'b', text: 'No'},
        ],
        parking: ""

      },
    };
  },
  methods: {
    onSubmit() {
      const newUnit = {
        types: this.unit.types,
        address: this.unit.address,
        city: this.unit.city,
        state: this.unit.state,
        zipCode: this.unit.zipCode,
        imgUrl: this.unit.imgUrl,
        rentAmount: this.unit.rentAmount,
        rentDueDate: this.unit.rentDueDate,
        buildingNumber: this.unit.buildingNumber,
        unitNumber: this.unit.unitNumber,
        bedrooms: this.unit.bedrooms,
        bathrooms: this.unit.bathrooms,
        pets: this.unit.pets,
        smoking: this.unit.smoking,
        pool: this.unit.pool,
        parking: this.unit.parking,
        
      };

        propertyService
          .addNewUnit(newUnit)
          .then((response) => {
            if (response.status === 204) {
              this.$router.push(`/units`);
            }
          })
          .catch((error) => {
            this.handleErrorResponse(error, "adding");
          });
    },

    onReset(event) {
      event.preventDefault();
      // Reset our form values
      this.form.name = "";
      this.form.description = "";
      this.form.address = "";
      this.form.city = "";
      this.form.state = "";
      this.form.zip = "";
      this.form.url = "";
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    },
  },
};
</script>
