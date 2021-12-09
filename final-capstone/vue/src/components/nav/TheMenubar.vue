<template>
    <header id="menubar">
    <nav>
      <ul id="menu">
        <li><a href="/">Home</a></li>
        <li><a href="properties">Properties</a></li>
        <li><a href="#">Gallery</a></li>
        <li><a href="#">Contact Us</a></li>
      </ul>
    </nav>
  </header>
</template>

<script>
export default {

}
</script>

<style scoped>
body {
  margin: 20px;
  padding: 0
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