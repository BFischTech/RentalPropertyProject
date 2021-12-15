<template>
  <div class="container">
    <br>
    <b-form @submit.prevent="onSubmit" @reset="onReset" v-if="show">
      <b-form-group
        id="input-group-1"
        label="Email and/or Phone #"
        label-for="input-1"
        description="We super promise not to use this for nefarious gain"
      >
        <b-form-input
          id="input-1"
          v-model="form.email"
          type="string"
          placeholder="Enter preferred method of contact"
          required
        ></b-form-input>
      </b-form-group>
      <br>
      <b-form-group id="input-group-2" label="Your Name:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.name"
          placeholder="Enter name"
          required
        ></b-form-input>
      </b-form-group>
<br>
      <b-form-group id="input-group-3" label="How can we help you?" label-for="input-3">
        <b-form-select
          id="input-3"
          v-model="form.food"
          :options="foods"
          required
        ></b-form-select>
      </b-form-group>

  <br>
  <div>
    <b-form-textarea
      id="textarea"
      v-model="text"
      placeholder="Please tell us more..."
      rows="3"
      max-rows="6"
    ></b-form-textarea>

    <pre class="mt-3 mb-0">{{ text }}</pre>
    <br>
  </div>
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
          email: '',
          name: '',
          food: null,
          checked: []
        },
        foods: [{ text: 'Select One', value: null }, 'I\'d like to tour a unit.', 'Professional Media', 'I\'ve fallen and can\'t get up!', 'Tenant complaint'],
        show:true,
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
        this.form.food = null
        this.form.checked = []
        this.text = ''
        this.text.placeholder = 'Please tell us more...'
        // Trick to reset/clear native browser form validation state
        this.show = false
        this.$nextTick(() => {
          this.show = true
        })
      }
    }
  }
</script>
