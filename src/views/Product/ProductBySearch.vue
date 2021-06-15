<template >
    <v-container >
        <v-card-title class="d-flex justify-space-between mb-6 mt-6 ">
          <div v-if="this.$route.params.query != 'all'">Search : {{ this.$route.params.query }} </div>
          <div v-else>Discover all </div>
          <div>
            <v-btn @click="sorting" tile class="ma-2 white--text" color="blue-grey darken-4">Price<v-icon class="ml-2" small>{{ iconSort }} </v-icon> </v-btn>
          </div>
        </v-card-title>

        <v-row>
          <v-col v-for="item in products" :key="item.id" cols="6" md="3" class="mb-6">
            <v-card>
              <v-img
              fluid
                :src="item.src"
                height="200px"
              ></v-img>
              <v-card-title class="subtitle-1">
                {{ item.name.substring(0,25)+"..." }}
              </v-card-title>
              <v-card-subtitle>
                <router-link :to="item.category.url">{{ item.category.name }}</router-link><br>
                <p class="text-right subtitle-1 success--text">{{"Rp. "+ (item.price/1000).toFixed(3) }} </p>  
              </v-card-subtitle>
                <v-divider></v-divider>

              <v-card-actions>
                <v-btn
                  text
                  color="dark"
                  block
                  small
                  :to="/product/+`${item.id}`"
                >
                  <v-icon small class="mr-1">mdi-eye</v-icon> Detail
                </v-btn>
              </v-card-actions>
              
            </v-card>
          </v-col>
            
        </v-row>
        <v-overlay :value="overlay">
            <v-progress-circular
                indeterminate
                size="64"
            ></v-progress-circular>
        </v-overlay>
        <v-snackbar
            timeout="4000"
            :color="color"
            v-model="snackbar"
            top
            right
        >
            {{ error_message }}
        </v-snackbar>
    </v-container>

</template>
<script>
  export default {
    data () {
      return {
        overlay:false,
        search: '',
        error_message:'',
        snackbar:false,
        color:'',
        iconSort:'mdi-sort-descending',
        products: []
      }
    },

    methods:{
        sorting(){
            if(this.iconSort=="mdi-sort-descending"){
                this.iconSort = "mdi-sort-ascending";
                this.products.sort(function(a,b){
                  return a.price - b.price;
                });
            }
            else{
                this.iconSort = "mdi-sort-descending";
                this.products.sort(function(a,b){
                  return b.price - a.price;
                });
            }
        },
        getProducts(){
            this.products = [];
            this.overlay = true;
            var url = this.$api + '/product/search/'+this.$route.params.query;
            this.$http.get(url, null,{
            }).then(response => {
              console.log(response);
                for(var i = 0 ; i< response.data.data.length; i++){
                  var product = {
                      id: response.data.data[i].id,
                      src: this.$storageUrl+response.data.data[i].image.split(":")[1].split('"')[1],
                      name: response.data.data[i].name,
                      price: response.data.data[i].price,
                      description: response.data.data[i].description,
                      category:{
                        name:response.data.data[i].category.name,
                        url:'/category/'+response.data.data[i].category.slug,
                      }
                  }
                  this.products.push(product);
                }
                this.overlay = false;
            }).catch(error => {
                this.overlay = false;
                this.error_message= error.response.data.message;
                this.color = "red";
                this.snackbar =true;
            })
        },

    },
    mounted(){
        this.getProducts();
    },
    watch:{
        $route (to, from){
            this.getProducts();
            console.log(to,from);
        }
    }
  }
</script>