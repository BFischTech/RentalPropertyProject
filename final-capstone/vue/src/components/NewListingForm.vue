<template>
  <div class="container">
    <br />

    <b-card bg-variant="light">
    <b-form @submit.prevent="onSubmit" @reset="onReset" v-if="show">
      <b-form-group
        id="input-group-1"
        label="Enter New Property Listing Details"
        label-for="input-group-1"
      >

        <b-form-input
          id="input-2"
          v-model="form.name"
          type="string"
          placeholder="Name of property"
          required
        ></b-form-input>
        
        <br />
        
        <b-form-input
          id="input-3"
          v-model="form.description"
          type="string"
          placeholder="Description"
          required
        ></b-form-input>

        <br/>
        
        <b-form-input
          id="input-4"
          v-model="form.address"
          type="string"
          placeholder="Address"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-5"
          v-model="form.city"
          type="string"
          placeholder="City"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-6"
          v-model="form.state"
          type="string"
          placeholder="State"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-7"
          v-model="form.zip"
          type="string"
          placeholder="Zip Code"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-8"
          v-model="form.url"
          type="string"
          placeholder="Image URL"
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-9"
          v-model="form.caption"
          type="string"
          placeholder="Image Caption"
        ></b-form-input>

        <br/>

        <b-form-select
          id="input-10"
          v-model="form.type"
          :options="types"
          required
        ></b-form-select>

        <br/>

        <b-form-input
          id="input-11"
          v-model="form.rentAmount"
          type="number"
            pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$"
            value=""
            data-type="currency"
            placeholder="$1.00"
            required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-12"
          v-model="form.rentDueDate"
          type="number"
          placeholder="Rent Due Date"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-13"
          v-model="form.buildingNumber"
          type="number"
          placeholder="Building Number"
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-14"
          v-model="form.unitNumber"
          type="number"
          placeholder="Unit Number"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-15"
          v-model="form.bedrooms"
          type="number"
          placeholder="Number of Bedrooms"
          required
        ></b-form-input>

        <br/>

        <b-form-input
          id="input-16"
          v-model="form.bathrooms"
          type="decimal"
          placeholder="Number of Bathrooms"
          required
        ></b-form-input>

        <br/>

        <p id="petsAllowed">Pets Allowed?</p>
        <b-form-select
          id="input-17"
          v-model="form.pets"
          :options="pets"
          required
        ></b-form-select>

        <br/>

        <p id="smokingAllowed">Smoking Allowed?</p>
        <b-form-select
          id="input-18"
          v-model="form.smoking"
          :options="smoking"
          required
        ></b-form-select>

        <br/>

        <p id="poolAccess">Pool?</p>
        <b-form-select
          id="input-19"
          v-model="form.pool"
          :options="pool"
          required
        ></b-form-select>

        <br/>

        <b-form-input
          id="input-20"
          v-model="form.parking"
          type="number"
          placeholder="Number of Parking Spots"
          required
        ></b-form-input>

        <br/>



        

      
      
      
      
      
      
      
      </b-form-group>
      </b-form>
      </b-card>
      
      <!-- <pre class="mt-3 mb-0">{{ text }}</pre>
        <br />
      </div>
      <b-button type="submit" variant="primary">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button> -->
  

        
    
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        email: "",
        name: "",
        food: null,
        checked: [],
      },
      foods: [
        { text: "Select One", value: null },
        "I'd like to tour a unit.",
        "Professional Media",
        "I've fallen and can't get up!",
        "Tenant complaint",
      ],
      show: true,
      text: "",
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
      this.form.email = "";
      this.form.name = "";
      this.form.food = null;
      this.form.checked = [];
      this.text = "";
      this.text.placeholder = "Please tell us more...";
      // Trick to reset/clear native browser form validation state
      this.show = false;
      this.$nextTick(() => {
        this.show = true;
      });
    },
  },
};
</script>
