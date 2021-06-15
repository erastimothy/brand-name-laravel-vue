<template>
  <v-card
    class="mx-auto overflow-hidden"
    height="50"
  >
    <v-app-bar
      color="grey darken-4"
      dark
      app
    >
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      
      <v-toolbar-title><v-btn exact text to="/home"><h2> BRAND NAME</h2></v-btn> </v-toolbar-title>

      <v-spacer></v-spacer>
      <v-text-field
        v-model="search"
        label="Search"
        single-line
        ref="search"
        append-icon="mdi-magnify"
        hide-details
        v-show="searchIcon"
        @focus="searchIcon = true"
        @blur="searchIcon = false"
        @keyup.enter="findProducts"
      ></v-text-field>
      <v-spacer></v-spacer>
      
      <v-btn icon class="mr-3" @click="searchIcon =! searchIcon" v-show="!searchIcon">
          <v-icon >mdi-magnify </v-icon>
      </v-btn>
      <v-btn icon class="mr-3" to="/cart" v-if="isLogin && cart.count>0">
          <v-badge
          color="green darken-2"
          overlap
          :content="cart.count"
        >
          <v-icon >mdi-cart </v-icon>
        </v-badge>
      </v-btn>
      
      <v-btn icon class="mr-3" to="/cart" v-else-if="isLogin && cart.count==0">
          <v-icon >mdi-cart </v-icon>
      </v-btn>
      <v-btn icon class="mr-3" to="/login" v-else>
          <v-icon >mdi-cart </v-icon>
      </v-btn>

      <v-btn icon v-if="isLogin" >
        <v-tooltip bottom>
            <template v-slot:activator="{ on, attrs }">
                <v-icon v-bind="attrs" v-on="on" color="red" @click="dialogLogout = true">mdi-power</v-icon>
            </template>
            <span>Logout</span>
          </v-tooltip>
      </v-btn>
      
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      app
      temporary
      width="300"
    >
      <v-list
        nav
        dense
      >
      <template v-if="isLogin" >
        <v-list-item two-line to="/profile">
          <v-list-item-avatar>
            <img :src="avatar">
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title>{{ name }} </v-list-item-title>
            <v-list-item-subtitle>{{ email }} </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </template>
      
      <template v-else>
        <v-list-item two-line>
          <v-list-item-avatar>
            <img :src="avatar">
          </v-list-item-avatar>

          <v-list-item-content>
            <v-list-item-title>            
              <v-btn color="cyan darken-4" text class="white--text" small to="/login">Masuk </v-btn> | <v-btn text class="white--text" color="brown lighten-1primary" small to="/register">Daftar </v-btn> 
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </template>
        <v-list-item-group
          v-model="group"
          active-class="grey darken-1--text text--accent-4"
        >
          <v-divider></v-divider>
          <router-link to="/my-order" tag="p" class="mt-4" v-if="isLogin">
            <v-list-item>
                <v-list-item-icon>
                  <v-icon>mdi-shopping</v-icon>
                </v-list-item-icon>
                <v-list-item-title>My Order</v-list-item-title>
            </v-list-item>
          </router-link>
          <v-subheader class="mb-5">Category</v-subheader>
          <router-link v-for="route in routes" :key="route.path" :to="route.path" tag="p">
            <v-list-item>
                <v-list-item-icon>
                  <v-icon>{{route.icon}}</v-icon>
                </v-list-item-icon>
                <v-list-item-title>{{route.name}}</v-list-item-title>
            </v-list-item>
          </router-link>
        
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
    <v-dialog v-model="dialogLogout" persistent max-width="400px">
        <v-card>
            <v-card-title class="headline">Are you gonna leave ?</v-card-title>
            <v-card-text>dont leave me... visit me more often pleasee <v-icon>mdi-emoticon-wink-outline</v-icon></v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="dialogLogout = false" class="mr-5">Nope</v-btn>
                <v-btn color="red darken-1" class="white--text ml-5" @click="logout">Sure</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    <v-snackbar
      timeout="4000"
      :color="color"
      v-model="snackbar"
      right
      top
  >
      {{ error_message }}
  </v-snackbar>
  </v-card>

  
</template>

<script>

export default {
  name: 'Bars',

  data(){
    return{
      drawer: false,
      group: null,
      searchIcon:false,
      search:'',
      color:'',
      snackbar:false,
      error_message:'',
      name:'Full name',
      email:'email@example.com',
      dialogLogout:false,
      isLogin: false,
      avatar:'https://randomuser.me/api/portraits/women/81.jpg',
      routes:[],
      cart:{
        count:0,
      },
    }
  },
  methods:{
    findProducts(){
      this.$router.push({
        path:'/search/'+this.search
      })
    },
    getCategory(){
          var url = this.$api + '/category';
          this.$http.get(url, null,{
          }).then(response => {
            if(response.message != "Empty"){

              for(var i =0 ; i< response.data.data.length; i++){
                var route = {
                    path:"/category/"+response.data.data[i].slug,
                    name:response.data.data[i].name,
                    icon:response.data.data[i].icon,
                }
                this.routes[i] = route;
              }
            }
          }).catch(error => {
              console.log(error.response);
          })
    },
    checkLogin(){
        if(localStorage.getItem("access_token") != null){
          this.isLogin = true;
          this.name = localStorage.getItem('name');
          this.email = localStorage.getItem('email');
          this.avatar = this.$storageUrl+localStorage.getItem('avatar');
          this.getCart();
        }else {
          this.isLogin = false;
        }
    },
    getCart(){
          this.$http.get(this.$api + '/cart',
          {
              headers: {
                  'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
              }, 
          }).then(response => {
            if(response.data.message != "Empty"){
                this.cart = {
                  count:response.data.data.length
                }
            }
             
          }).catch(error => {
              console.log(error);
          })
    },
    logout(){
      localStorage.clear();
      this.color = "green";
      this.error_message = "Succesfully Logout !";
      this.snackbar= true;
      window.location.reload();
      this.dialogLogout = false;
    },
  },
  mounted(){
    this.getCategory();
    this.checkLogin();
  },
};
</script>