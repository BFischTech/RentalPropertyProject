<template>
  <div id="app">
  <the-header></the-header>
  <the-menubar></the-menubar>
  <router-view></router-view>
  <the-footer></the-footer>
  </div>
</template>

<script>
import TheHeader from './components/header/TheHeader.vue';
import TheMenubar from './components/nav/TheMenubar.vue';
import TheFooter from './components/footer/TheFooter.vue';

export default {
  components: { 
    TheHeader,
    TheMenubar,
    TheFooter
  },
};
</script>

<style>



</style>