<template>
    <header id="menubar">
    <nav>
      <ul id="menu">
        <li><a href="/">Home</a></li>
        <li><a href="/contact">Contact Us</a></li>
      </ul>
    </nav>
  </header>
</template>

<script>
export default {
  data(){
    return{
      mail : 'xavier.seignard+drangies@gmail.com',
      phone : '06.00.00.00.00',
      mention : '2018 | mentions légales'
    }
  }
}
</script>

<style scoped>
body {
  margin: 20px;
  padding: 0
}

header {
    margin-bottom: 15px;
}
header > nav {
  flex-grow: 1;

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
  justify-content: space-evenly;

}

header > nav > ul > li {
  font-family: 'Oswald', sans-serif;
  font-size: 3vh;
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