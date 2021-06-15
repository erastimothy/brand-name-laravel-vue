<template >
    <v-container >
        <v-card-title class="d-flex justify-space-between mb-6 mt-6 ">
          <div>{{ category }}</div>
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
                <router-link :to="item.category.url">{{ item.category.name }}</router-link>
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
    </v-container>

</template>
<script>
  export default {
    data () {
      return {
        search: '',
        iconSort:'mdi-sort-descending',
        products: [
        ],
        overlay:false,
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
            var url = this.$api + '/category/'+this.category.toLowerCase()+"/all";
            this.$http.get(url, null,{
            }).then(response => {
              console.log(response.data);
                for(var i = 0 ; i< response.data.data[0].products.length; i++){
                  var product = {
                      id: response.data.data[0].products[i].id,
                      src: this.$storageUrl+response.data.data[0].products[i].image.split(":")[1].split('"')[1],
                      name: response.data.data[0].products[i].name,
                      price: response.data.data[0].products[i].price,
                      description: response.data.data[0].products[i].description,
                      category:{
                        name:response.data.data[0].name,
                        url:'/category/'+response.data.data[0].slug,
                      }
                  }
                  this.products.push(product);
                }
                this.overlay = false;
                console.log(this.products);
            }).catch(error => {
                this.overlay = false;
                console.log(error);
            })
        },

    },

    computed:{
      category(){
        return this.$route.params.slug.toUpperCase();
      }
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