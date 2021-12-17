<template>
  <div class="container">
    <br>

    <b-card bg-variant="light">
      <b-form @submit.prevent="onSubmit">
        <b-form-group id="input-group-1">

          <div id="divOption">
            <label for="">Select Property Id:</label>&nbsp;
            <b-form-select v-model="createNewUnit.propertyId" required>
              <option value="" disabled>Property Id</option>
              <option v-for="property in properties" :value="property.propertyId" :key="property.propertyId">{{ property.propertyId }}</option>
            </b-form-select>
          </div>

          <br>
          <br>

          <b-form-radio-group v-model="createNewUnit.unitType" :aria-describedby="ariaDescribedby">
            <b-form-radio :aria-describedby="ariaDescribedby" name="house" :value="1" >&nbsp;House</b-form-radio>
            <b-form-radio :aria-describedby="ariaDescribedby" name="apartment" :value="2">&nbsp;Apartment</b-form-radio>
            <b-form-radio :aria-describedby="ariaDescribedby" name="condo" :value="3" >&nbsp;Condo</b-form-radio>
          </b-form-radio-group>

          <br>
          <br>

          <b-form-input id="input-2" v-model="createNewUnit.unitAddress" type="string" placeholder="Address" required></b-form-input>

          <br>

          <b-form-input id="input-3" v-model="createNewUnit.unitCity" type="string" placeholder="City" required></b-form-input>

          <br>

          <b-form-input id="input-4" v-model="createNewUnit.unitState" type="string" placeholder="State" required></b-form-input>

          <br>

          <b-form-input id="input-5" v-model="createNewUnit.unitZipCode" type="string" placeholder="Zip Code" required></b-form-input>

          <br>

          <b-form-input id="input-6" v-model="createNewUnit.imgUrl" type="string" placeholder="Image URL"></b-form-input>

          <br>

          <b-form-input id="input-7" v-model="createNewUnit.unitRentAmount" type="number" pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$" value="" data-type="currency" placeholder="$1.00" required></b-form-input>

          <br>

          <b-form-input id="input-8" v-model="createNewUnit.rentDueDate" type="number" placeholder="Rent Due Date" required></b-form-input>

          <br>

          <b-form-input id="input-9" v-model="createNewUnit.buildingNumber" type="number" placeholder="Building Number"></b-form-input>

          <br>

          <b-form-input id="input-10" v-model="createNewUnit.unitNumber" type="string" placeholder="Unit Number" required></b-form-input>

          <br>

          <b-form-input id="input-11" v-model="createNewUnit.bedroomCount" type="number" placeholder="Number of Bedrooms" required></b-form-input>

          <br>

          <b-form-input id="input-12" v-model="createNewUnit.bathroomCount" type="number" placeholder="Number of Bathrooms" required></b-form-input>

          <br>

          <b-form-checkbox id="checkbox-1" v-model="createNewUnit.petFriendly" name="checkbox-1" :value="true" :unchecked-value="false">&nbsp;Pets Allowed?</b-form-checkbox>
          
          <br>

          <b-form-checkbox id="checkbox-2" v-model="createNewUnit.smokingAllowed" name="checkbox-2" :value="true" :unchecked-value="false" >&nbsp;Smoking Allowed?</b-form-checkbox>

          <br>
          
          <b-form-checkbox id="checkbox-3" v-model="createNewUnit.poolAccess" name="checkbox-3" :value="true" :unchecked-value="false">&nbsp;Pool Access?</b-form-checkbox>

          <br>

          <b-form-input id="input-16" v-model="createNewUnit.parkingSpots" type="number" placeholder="Number of Parking Spots" required></b-form-input>

          <br>
        </b-form-group>

        <b-form-group class="buttons">
          <b-button class="submitButton" type="submit" variant="primary">Submit</b-button>
          <b-button class="resetButton" type="reset" variant="danger">Reset</b-button>
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
      createNewUnit: {
        propertyId: "",
        unitType: "",
        unitRentAmount: "",
        rentDueDate: "",
        buildingNumber: "",
        unitNumber: "",
        unitAddress: "",
        unitCity: "",
        unitState: "",
        unitZipCode: "",
        imgUrl: "",
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
      const newCreateNewUnit = {
        propertyId: parseInt(this.createNewUnit.propertyId),
        unitType: parseInt(this.createNewUnit.unitType),
        unitRentAmount: parseFloat(this.createNewUnit.unitRentAmount),
        rentDueDate: parseInt(this.createNewUnit.rentDueDate),
        buildingNumber: parseInt(this.createNewUnit.buildingNumber),
        unitNumber: this.createNewUnit.unitNumber,
        unitAddress: this.createNewUnit.unitAddress,
        unitCity: this.createNewUnit.unitCity,
        unitState: this.createNewUnit.unitState,
        unitZipCode: this.createNewUnit.unitZipCode,
        imgUrl: this.createNewUnit.imgUrl,
        bedroomCount: parseInt(this.createNewUnit.bedroomCount),
        bathroomCount: parseInt(this.createNewUnit.bathroomCount),
        petFriendly: this.createNewUnit.petFriendly,
        smokingAllowed: this.createNewUnit.smokingAllowed,
        poolAccess: this.createNewUnit.poolAccess,
        parkingSpots: parseFloat(this.createNewUnit.parkingSpots),
      };
      propertyService.AddNewUnit(newCreateNewUnit)
        .then((response) => {
          if (response.status === 204) {
            console.log("IT WORKS!!!!!!!");
            this.$router.push('unit');
          }
        })
        .catch((error) => {
          console.log(".............................");
          console.log(newCreateNewUnit);
          console.log(".............................");
          this.handleErrorResponse(error, "adding");
        });
    },
  },
};
</script>
