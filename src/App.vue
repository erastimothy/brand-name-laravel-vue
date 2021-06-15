<template>
  <v-app>
    <Bars/>
    <div>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </div>
    <Footer/>
  </v-app>
</template>

<script>
import Bars from '@/components/Bars';
import Footer from '@/components/Footer';

export default {
  name: 'App',

  components: {
    Bars,
    Footer,
  },

  data: () => ({
    banks: [
        'bca.png',
        'bni.jpeg',
        'dana.jpg',
        'gopay.jpg',
        'mandiri.jpg',
        'ovo.jpg'
      ],
    icons: [
        'mdi-facebook',
        'mdi-instagram',
        'mdi-whatsapp',
      ],
  }),
};
</script>

<style scoped>
  @media only screen and (max-width: 600px) {
  .logo-bank{
    width: 60px;
  }
  .location{
    width: 150px;
  }
}
  
</style>
