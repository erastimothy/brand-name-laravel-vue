<template >
    <v-container >
        <v-row>
            <v-col cols="12" md="4" class="mb-5">
                <v-img contain
                :src="product.image"></v-img>
            </v-col>
            <v-col cols="12" md="5" class="mb-5">
                <v-card-title >
                    <p >{{ product.title }}</p>
                </v-card-title>
                <v-card-subtitle>
                    <p class="subtitle-1 success--text">{{"Rp. "+ product.price}} </p>  
                </v-card-subtitle>
                <v-card-text>
                    <router-link :to="product.category_url">{{ product.category }}</router-link>
                    <div class="mt-5">
                        <p v-html="product.description"></p>
                    </div>
                </v-card-text>
            </v-col>
            <v-col cols="12" md="3" class="mb-5">
                <v-card elevation="2" outlined>
                    <v-card-text >
                        <strong >PILIH UKURAN</strong>
                        <v-select
                        class="mt-5"
                            dense
                            :items="['S','M','L','XL','XXL']"
                            label="Size"
                            outlined
                            v-model="size"
                            >
                        </v-select> 
                        <v-text-field
                            label="Quantity"
                            v-model="quantity"
                            type="number"
                            min="1"
                            :max="this.product.stock"
                            outlined
                            class="mb-6"
                            dense
                        ></v-text-field>

                        <v-text-field
                            label="Subtotal"
                            type="number"
                            :value="hitungSubtotal"
                            class="mt-6"
                            outlined
                            dense
                        ></v-text-field>
                    </v-card-text>
                    <v-card-actions>
                        <v-btn
                        :loading="loading"
                        :disabled="loading"
                        color="black" tile block class="white--text" @click="addToCart">Tambahkan ke keranjang</v-btn>
                    </v-card-actions>
                    
                </v-card>
            </v-col>
        </v-row>
        
        <v-snackbar
            timeout="2000"
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
        overlay:false,
        snackbar:false,
        loading:false,
        color:"",
        error_message:"",
        search: '',
        size:null,
        iconSort:'mdi-sort-descending',
        product:{
            price:0,
            category_url:'/category',
            category:'category'}, 
        quantity:1,
        subtotal:0,
      }
    },

    methods:{
        getProduct(){
            this.overlay = true;
            var url = this.$api + '/product/'+this.$route.params.id;
            this.$http.get(url)
              .then(response => {
                    this.product = {
                        id:response.data.data.id,
                        image: this.$storageUrl+response.data.data.image.split(":")[1].split('"')[1],
                        title:response.data.data.name,
                        price: response.data.data.price,
                        stock: response.data.data.stock,
                        description: response.data.data.description,
                        category:response.data.data.category.name,
                        category_url:'/category/'+response.data.data.category.slug,
                    }
                    //image respon
                    //"[{"download_link":"categories\\December2020\\Y5UxLrhjQ4G3numIgyWS.jpg","original_name":"326x400_WOMEN.jpg"}]"
                    
                    //result image : categories\\December2020\\Y5UxLrhjQ4G3numIgyWS.jpg
                    this.overlay = false;
              })
              .catch(err => {
                    this.overlay = false;
                    this.error_message = err.response.data.message;
                    this.color="red";
                    this.snackbar = true;
              })
        },
        validate(){
            if(this.size==null || this.size == ""){
                this.snackbar = true;
                this.error_message = "Pilih size terlebih dahulu";
                this.color = 'red';
                return false;
            }
            else if(parseInt(this.quantity) > parseInt(this.product.stock)){
                this.snackbar = true;
                this.error_message = "Melebihi batas stok";
                this.color = 'red';
                return false;
            }
            return true;
        },
        addToCart(){
            if(localStorage.getItem("access_token")!=null){
                if(this.validate()){
                    this.loading = true;
                    this.$http.post(this.$api + '/cart',
                    { //params
                            product_id: this.product.id,
                            quantity : this.quantity,
                            variance: this.size,
                            subtotal:this.hitungSubtotal,
                    }, {
                        headers: {
                            'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                        }, 
                    }).then(response => {
                        this.loading = false;
                        this.error_message =  response.data.message;
                        this.color = "green";
                        this.snackbar = true;
                        window.location.href ="/cart";
                    }).catch(err => {
                        this.loading = false
                        this.error_message =  err.response.data.message;
                        this.color = "red";
                        this.snackbar = true;
                    })
                }
            }else{
                this.snackbar = true;
                this.error_message = "Login first !";
                this.color="warning";
                this.$router.push('/login');
            }
        }
    },
    mounted(){
        this.getProduct();
    },
    computed:{
        hitungSubtotal(){
            let subtotal = this.quantity * this.product.price;
            return subtotal;
        }
    }
  }
</script>