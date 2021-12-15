<template>
  <div id="container">
    <b-form @submit="onSubmit" @reset="onReset" v-if="show">
      <b-form-group id="input-group-3" label="What seems to be the problem?" label-for="input-3">
        <b-form-select
            id="input-3"
            v-model="form.maintenance"
            :options="maintenanceTypes"
            required
        ></b-form-select>
      </b-form-group>
      <b-row class="mt-2">
        <b-col sm="2">
          <label>Concern:</label>
        </b-col>
        <b-col sm="10">
          <b-form-textarea
              v-model="form.textareaConcern"
              id="textarea-concern"
              placeholder="please describe the problem"
          ></b-form-textarea>
        </b-col>
      </b-row>
      <b-form-group id="input-status" label="Current Status" label-for="input-3">
        <b-form-select
            id="input-3"
            v-model="form.maintenanceStatus"
            :options="maintenanceStatus"
            required
        ></b-form-select>
      </b-form-group> <br>
      <b-button type="submit" variant="primary">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        maintenance: null,
        textareaConcern: null,
        maintenanceStatus: '',
      },
      maintenanceTypes: [{text: 'Select One', value: null}, {text: 'Electrical', value: 1}, {
        text: 'Fences',
        value: 2
      }, {text: 'Painting', value: 3}, {text: 'Plumbing', value: 4}, {text: 'Drywall', value: 5}, {
        text: 'Others',
        value: 6
      }],
      maintenanceStatus: [{text: 'Pending', value: 1}, { 
        text: 'Cancelled',
        value: 2
      }, {text: 'Completed', value: 3}],
  
    show: true
  }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault()
      alert(JSON.stringify(this.form))
    },
    onReset(event) {
      event.preventDefault()
      // Reset our form values
      this.form.email = ''
      this.form.name = ''
      this.form.maintenance = null
      this.form.checked = []
      // Trick to reset/clear native browser form validation state
      this.show = false
      this.$nextTick(() => {
        this.show = true
      })
    }
  }
}
</script>

<style scoped>

#container {
  display: flex;
  flex-direction: column;
  margin: auto;
  justify-content: space-evenly;
}

</style>