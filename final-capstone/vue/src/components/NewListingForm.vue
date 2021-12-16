<template>
  <div class="container">
    <br />

    <b-card bg-variant="light">
      <b-form @submit.prevent="onSubmit" @reset="onReset">
        <b-form-group id="input-group-1">
          <b-form-input
            id="input-2"
            v-model="property.propertyName"
            type="string"
            placeholder="Name of property"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-3"
            v-model="property.propertyDescription"
            type="string"
            placeholder="Description"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-4"
            v-model="property.propertyAddress"
            type="string"
            placeholder="Address"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-5"
            v-model="property.propertyCity"
            type="string"
            placeholder="City"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-6"
            v-model="property.propertyState"
            type="string"
            placeholder="State"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-7"
            v-model="property.propertyZipCode"
            type="string"
            placeholder="Zip Code"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-8"
            v-model="property.propertyImgUrl"
            type="string"
            placeholder="Image URL"
          ></b-form-input>

          <br />
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
    propertyId: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      property: {
        propertyName: "",
        propertyDescription: "",
        propertyAddress: "",
        propertyCity: "",
        propertyState: "",
        propertyZipCode: "",
        propertyImgUrl: "",
      },
    };
  },
  methods: {
    onSubmit() {
      const newProperty = {
        propertyName: this.property.propertyName,
        propertyDescription: this.property.propertyDescription,
        propertyAddress: this.property.propertyAddress,
        propertyCity: this.property.propertyCity,
        propertyState: this.property.propertyState,
        propertyZipCode: this.property.propertyZipCode,
        propertyImgUrl: this.property.propertyImgUrl,
      };


        propertyService
          .addNewProperty(newProperty)
          .then((response) => {
            if (response.status === 204) {
              this.$router.push(`/properties`);
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
