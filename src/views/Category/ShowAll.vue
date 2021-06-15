<template >
    <v-container fluid >
        <v-card-title class="d-flex justify-space-between mb-6 mt-6 ">
          <div>Category</div>
          <div>
            <v-btn @click="sorting" tile class="ma-2 white--text" color="blue-grey darken-4" >Name<v-icon class="ml-2" small>{{ iconSort }} </v-icon> </v-btn>
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
        iconSort:'mdi-sort-alphabetical-descending',
        bannerCategory:[],
        overlay:false,
      }
    },

    methods:{
        sorting(){
            if(this.iconSort=="mdi-sort-alphabetical-descending"){
                this.iconSort = "mdi-sort-alphabetical-ascending";
                this.bannerCategory.sort((a,b) => 
                a.name.localeCompare(b.name));
            }
            else{
                this.iconSort = "mdi-sort-alphabetical-descending";
                this.bannerCategory.sort((a,b) => 
                b.name.localeCompare(a.name));
            }

        },
        getCategory(){
          this.overlay = true;
            var url = this.$api + '/category';
            this.$http.get(url)
              .then(response => {
                  for(var i =0 ; i< response.data.data.length; i++){
                    var banner = {
                        src: this.$storageUrl+ response.data.data[i].image.split(":")[1].split('"')[1],
                        path:'/category/'+response.data.data[i].slug,
                        name: response.data.data[i].name,
                    }
                    this.bannerCategory.push(banner);
                    //image respon
                    //"[{"download_link":"categories\\December2020\\Y5UxLrhjQ4G3numIgyWS.jpg","original_name":"326x400_WOMEN.jpg"}]"
                    
                    //result image : categories\\December2020\\Y5UxLrhjQ4G3numIgyWS.jpg
                  }
              this.overlay = false;
              })
              .catch(err => {
                  this.overlay = false;
                  console.log(err);
              })
        },
    },
    mounted(){
      this.getCategory();
    }
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