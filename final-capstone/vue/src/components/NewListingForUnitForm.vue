<template>
  <div class="container">
    <br />



    <b-card bg-variant="light">
      <b-form @submit.prevent="onSubmit" @reset="onReset">
        <b-form-group id="input-group-1">
          <div id="divOption">
            <label for="">Select Property Id:</label>&nbsp;
            <b-form-select v-model="unit.propertyId" required>
              <option value="" disabled>Property Id</option>
              <option
                v-for="property in properties"
                :value="property.propertyId"
                :key="property.propertyId"
              >
                {{ property.propertyId }}
              </option>
            </b-form-select>
          </div>

          <br />
          <br />

          <b-form-radio
            v-model="unit.unitType"
            :aria-describedby="ariaDescribedby"
            name="apartment"
            :value="2"
            >&nbsp;Apartment</b-form-radio
          >
          <b-form-radio
            v-model="unit.unitType"
            :aria-describedby="ariaDescribedby"
            name="house"
            :value="1"
            >&nbsp;House</b-form-radio
          >
          <b-form-radio
            v-model="unit.unitType"
            :aria-describedby="ariaDescribedby"
            name="condo"
            :value="3"
            >&nbsp;Condo</b-form-radio
          >

          <br />
          <br />

          <b-form-input
            id="input-2"
            v-model="unit.unitAddress"
            type="string"
            placeholder="Address"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-3"
            v-model="unit.unitCity"
            type="string"
            placeholder="City"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-4"
            v-model="unit.unitState"
            type="string"
            placeholder="State"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-5"
            v-model="unit.unitZipCode"
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
            v-model="unit.unitRentAmount"
            type="number"
            pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$"
            value=""
            data-type="currency"
            placeholder="$1.00"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-8"
            v-model="unit.rentDueDate"
            type="number"
            placeholder="Rent Due Date"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-9"
            v-model="unit.buildingNumber"
            type="number"
            placeholder="Building Number"
          ></b-form-input>

          <br />

          <b-form-input
            id="input-10"
            v-model="unit.unitNumber"
            type="string"
            placeholder="Unit Number"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-11"
            v-model="unit.bedroomCount"
            type="number"
            placeholder="Number of Bedrooms"
            required
          ></b-form-input>

          <br />

          <b-form-input
            id="input-12"
            v-model="unit.bathroomCount"
            type="decimal"
            placeholder="Number of Bathrooms"
            required
          ></b-form-input>

          <br />

            <b-form-checkbox
            id="checkbox-1"
            v-model="unit.petFriendly"
            name="checkbox-1"
            :value="1"
            :unchecked-value="0"
            >&nbsp;Pets Allowed?
          </b-form-checkbox>
          
          <br>

            <b-form-checkbox
            id="checkbox-2"
            v-model="unit.smokingAllowed"
            name="checkbox-2"
            :value="1"
            :unchecked-value="0"
            >&nbsp;Smoking Allowed?
          </b-form-checkbox>

          <br>
          
          <b-form-checkbox
            id="checkbox-3"
            v-model="unit.poolAccess"
            name="checkbox-3"
            :value="1"
            :unchecked-value="0"
            >&nbsp;Pool Access?
          </b-form-checkbox>

          <br />

          <b-form-input
            id="input-16"
            v-model="unit.parkingSpots"
            type="number"
            placeholder="Number of Parking Spots"
            required
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
    unitId: {
      type: Number,
      default: 0,
    },

  },
  data() {
    return {
      properties: [],
      unit: {
        propertyId: 0,
        unitType: "",
        unitAddress: "",
        unitCity: "",
        unitState: "",
        unitZipCode: "",
        imgUrl: "",
        unitRentAmount: "",
        rentDueDate: "",
        buildingNumber: "",
        unitNumber: "",
        bedroomCount: "",
        bathroomCount: "",
        petFriendly: false,
        smokingAllowed: false,
        poolAccess: false,
        parkingSpots: "",
      },
    };
  },
created() {
    propertyService.getAllPropertiesByOwnerId().then(response => {
      this.properties = response.data;
    });
},

  methods: {
    onSubmit() {
      const newUnit = {
        propertyId: this.unit.propertyId,
        unitType: this.unit.unitType,
        unitAddress: this.unit.unitAddress,
        unitCity: this.unit.unitCity,
        unitState: this.unit.unitState,
        unitZipCode: this.unit.unitZipCode,
        imgUrl: this.unit.imgUrl,
        unitRentAmount: parseInt(this.unit.unitRentAmount),
        rentDueDate: this.unit.rentDueDate,
        buildingNumber: this.unit.buildingNumber,
        unitNumber: this.unit.unitNumber,
        bedroomCount: this.unit.bedroomCount,
        bathroomCount: this.unit.bathroomCount,
        petFriendly: this.unit.petFriendly,
        smokingAllowed: this.unit.smokingAllowed,
        poolAccess: this.unit.poolAccess,
        parkingSpots: this.unit.parkingSpots,
      };


      propertyService
        .addNewUnit(newUnit)
        .then((response) => {
          if (response.status === 204) {
            this.$router.push(`/Unit`);
          }
        })
        .catch((error) => {
          console.log("text looking good clark");
          console.log(newUnit);
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
