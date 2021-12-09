<template>
  <div class="the-header"><img id="logo" src="logo.png" alt="stuff">
    <router-link class="link" to="/">Home</router-link>
    <router-link class="link" to="/login">Login</router-link>
    <router-link class="link" to="/logout">Logout</router-link>
    <router-link class="link" to="/register">Register</router-link>
  
  
  <b-button>Button</b-button>
  <b-button variant="danger">Button</b-button>
  <b-button variant="success">Button</b-button>
  <b-button variant="outline-primary">Button</b-button>
</div>
</template>

<script>
export default {
  name: "the-header",
};
</script>


<style scoped>


a:visited {
  color: #3b4954;
}
a {
  color: #dbffd7;
}

.link {
  text-decoration: none;

  }


#logo {
  width: 15rem;
  border-radius: 10px;
}


.the-header {
  grid-area: the-header;
  background-color: #80B969;
  display: flex;
  font-size: 5rem;
  flex-direction: row;
  align-items: center;
  border-radius: 10px;
  justify-content: space-between;
  padding: 10px 12rem;
  flex-wrap: wrap;
}

.container {
  display: grid;
  grid-template-areas: "the-header the-header the-header";
  grid-template-columns: 200px 1fr 200px;
  gap: 10px;
  
}

@media screen and (max-width: 1024px) {
  .container {
    display: grid;
    grid-template-areas: "the-header the-header";
    grid-template-columns: 1fr 1fr;
  }
}

@media screen and (max-width: 768px) {
  .container {
    display: grid;
    grid-template-areas: "the-header";
    grid-template-columns: 1fr;
  }
}
</style>