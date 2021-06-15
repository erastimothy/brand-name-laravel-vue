<template >
    <v-container fluid>
        <v-carousel hide-delimiter-background cycle interval="4000">
          <v-carousel-item
            v-for="(item,i) in banners"
            :key="i"
            :src="item.src"
          ></v-carousel-item>
        </v-carousel>

        <v-card-title class="d-flex justify-space-between mb-6 mt-6 ">
          <div>Category</div>
          <div>
            <v-btn outlined to="/category"><strong>More</strong> </v-btn>
          </div>
        </v-card-title>
        <v-row>
          <v-col v-for="(item,i) in bannerCategory" :key="i" cols="6" md="3">
            <v-hover v-slot="{ hover }">
              <v-card :to="item.path">
                <v-img :src="item.src">
                    <v-expand-transition>
                        <div
                            v-if="hover"
                            class="d-flex transition-fast-in-fast-out black darken-2 v-card--reveal display-3 white--text"
                            style="height: 100%;"
                        >
                            {{ item.name }}
                        </div>
                    </v-expand-transition>
                </v-img>
              </v-card>
            </v-hover>
          </v-col>
        </v-row>

        <v-card-title class="d-flex justify-space-between mb-6 mt-6 ">
          <div>Discover</div>
          <div>
            <v-btn outlined to="/search/all"><strong>More</strong> </v-btn>
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
        <v-dialog
            v-model="dialogPopUp"
            max-width="800px"
            scrollable
            transition="dialog-transition"
        >     
            
                <v-img src="img/banner/20201204_175135_bigger.jpg">
                    <v-btn
                        icon
                        class="d-flex justify-right"
                        right
                        @click="dialogPopUp = false"
                    >
                        <v-icon>mdi-close</v-icon>
                    </v-btn>
                </v-img>
        </v-dialog>

        <v-snackbar
            timeout="4000"
            :color="color"
            v-model="snackbar"
            top
            right
        >
            {{ error_message }}
        </v-snackbar>

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
        overlay:false,
        snackbar:false,
        color:'',
        error_message:'',
        dialogPopUp:true,
        categories:[],
        products: [],
        bannerCategory:[
        ],
        banners: [
          {src: 'img/banner/20201203_093455_bigger.jpg',},
          {src: 'img/banner/20201124_104920_bigger.jpg',},
          {src: 'img/banner/20201125_094012_bigger.jpg',},
          {src: 'img/banner/20201130_171857_bigger.jpg',},
        ],
      }
    },
    methods:{
        getCategory(){
            this.overlay = true;

            var url = this.$api + '/category';

            this.$http.get(url, null,{
            }).then(response => {
                for(var i =0 ; i< response.data.data.length; i++){
                  this.categories[i] = response.data.data[i];
                  //image respon
                  //"[{"download_link":"categories\\December2020\\Y5UxLrhjQ4G3numIgyWS.jpg","original_name":"326x400_WOMEN.jpg"}]"
                  this.categories[i].image = this.categories[i].image.split(":")[1].split('"')[1];
                  //result image : categories\\December2020\\Y5UxLrhjQ4G3numIgyWS.jpg
                }
                for (let i =0 ;i < 4; i++){
                  var banner = {
                      src:this.$storageUrl+this.categories[i].image,
                      path:'/category/'+this.categories[i].slug,
                      name:this.categories[i].name,
                  }
                  this.bannerCategory.push(banner);
                }
                this.overlay = false;
            }).catch(error => {
                this.overlay = false;
                console.log(error.response);
            })
        },
        getProducts(){
            this.overlay = true;
            this.products = [];
            //8 = 8 product
            var url = this.$api + '/product/discover/8';
            this.$http.get(url, null,{
            }).then(response => {
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
                console.log(error);
            })
        },
        
    },
    mounted(){
      this.getCategory();
      this.getProducts();
      this.overlay = true;
    },

  }
</script>

<style>
.v-card--reveal {
  align-items: center;
  bottom: 0;
  justify-content: center;
  opacity: 0.8;
  position: absolute;
  width: 100%;
}
</style>