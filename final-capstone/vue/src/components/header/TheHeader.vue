<template>
    <div id="ll-grid">
      <div id="ll-child-grid">
        <div id="logo-bar">
          <a href="#">
            <img src="logo.png" alt="Tech Elevator Logo" class="logo">
          </a>
        </div> 

        <div id="social-bar">    
        <ul>  
            <i class="fa fa-facebook-official" aria-hidden="true">  <a href="https://www.facebook.com/techelevator/" target="_blank">Like us on Facebook</a></i>
            <br>
            <i class="fa fa-instagram" aria-hidden="true">  <a href="https://www.instagram.com/techelevator/?hl=en" target="_blank">Follow us on instagram</a></i>
            <br>
            <i class="fa fa-phone-square" aria-hidden="true"> <a>1 (439) 3825 968</a></i>
          </ul>
        </div> 
      </div>
      
      <b-button class="w-50 h-65 loginButton" :to="$store.state.user.role" variant="outline-dark" pill="true" v-if="$store.state.token != ''">Welcome! {{ $store.state.user.role }}</b-button>
      <b-button class="w-50 h-65 loginButton" href="/logout" variant="outline-dark" pill="true" v-if="$store.state.token != ''">Logout</b-button>
      <b-button class="w-50 h-65 loginButton" href="/login" variant="outline-dark" pill="true" v-if="$store.state.token === ''">Login</b-button>
      <b-button class="w-50 h-65 loginButton" href="/register" variant="outline-dark" pill="true" v-if="$store.state.token === ''">Register</b-button>

    </div>
</template>



<style scoped>
@import url(https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css);
body {
  margin: 20px;
  padding: 0
}

header > nav {
  flex-grow: 1;
}


.loginButton {
  display:flex;
  font-size: 3vw;
  justify-content: center;
  align-self: center;
  align-items: center;
  padding-bottom: 1.2vw;
  justify-self: center;
  ;
}

#menubar {
  background-color: #95C482;
  padding: 20px;
}

#menubar, #menu {
  display: flex;
  align-items: center;
}

#menu {
  margin: 0;
  padding: 0;
  list-style-type: none;
}

#menu {
  justify-content: space-evenly;
}

header > nav > ul > li {
  font-family: 'Oswald', sans-serif;
  font-size: 20px;
  text-transform: uppercase;
  color: #707070;
  padding: 0 20px 0 0;
  margin-left: 20px;
}

ul > li > a,
a:visited {
  color: #707070;
  text-decoration: none;
}

ul > li > a:hover {
  color: #00AFEF;
  text-decoration: underline;
  
}

.logo {
  width: 140px;
}

#ll-grid {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  grid-template-areas:
    "ll-child-grid ll-child-grid login-bar";
  align-items: left;
}

#login-bar {
  grid-area: login-bar;
}

#ll-child-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-areas:
    "logo-bar social-bar";
  align-items: center;
}

#logo-bar {
  text-align: center;
  grid-area: logo-bar;
}
#social-bar {
  grid-area: social-bar;
}
</style>