<template>
    <v-container>
        <v-row>
            <v-overlay :value="overlay">
                <v-progress-circular
                    indeterminate
                    size="64"
                ></v-progress-circular>
            </v-overlay>
            <v-col cols="12" md="8">
                <v-card dark tile elevation-4>
                    <v-card-title>Cart</v-card-title>
                    <v-card-text>
                        <div v-if="carts == null" class="mb-6 mt-6">
                            <h3 class="text-center">...KOSONG NIH...<br>...BELANJA DULU YUK...</h3>
                        </div>
                        <v-row v-else class="mb-3"  v-for="(cart,index) in carts" :key="index">
                            <v-col cols="3">
                                <v-img
                                    :src="cart.product.image" class="thumbnail">
                                </v-img>
                            </v-col>
                            <v-col cols="5">
                                <span class="subtitle-1">{{cart.product.name}}</span> 
                                <p class="subtitle-2">Size : {{ cart.variance }}</p>
                                <p class="subtitle-2 green--text" >Rp. {{ cart.product.price }} </p>
                                <div>
                                    <v-btn icon small @click="min(cart,index)"><v-icon small>mdi-minus</v-icon></v-btn> 
                                        <span class="subtitle-1 mr-2 ml-2 ">{{ cart.quantity }} </span>
                                    <v-btn icon small @click="plus(cart,index)"><v-icon small>mdi-plus</v-icon></v-btn> 
                                </div>
                            </v-col>
                            <v-col cols="4">
                                <p class="subtitle-1">
                                    Rp. {{ cart.subtotal }}
                                </p>
                            </v-col>
                        </v-row>
                        <v-divider></v-divider>
                    </v-card-text>
                </v-card>
            </v-col>
            <v-col cols="12" md="4">
                <v-card dark tile elevation-4>
                    <v-card-title>Payment</v-card-title>
                    <v-divider></v-divider>
                    <v-container fluid>
                        <v-row class="ml-5 mt-4 mb-6">
                            <p v-html="address"></p>
                        </v-row>
                        <v-row class="mb-6 ml-2 mr-6">
                            <v-col cols="9">
                                <v-text-field
                                    name="coupon"
                                    label="Coupon"
                                    v-model="coupon"
                                    id="id"
                                    solo
                                    dense
                                    tile
                                    light
                                ></v-text-field>
                            </v-col>
                            <v-col cols="3" >
                                <v-btn color="success darken-2" @click="applyCoupon">APPLY</v-btn>
                            </v-col>
                        </v-row>

                        <v-row class="ml-3 ">
                            <v-col cols="6">
                                Subtotal
                            </v-col>
                            <v-col cols="6">
                                Rp. {{ subtotal }}
                            </v-col>
                        </v-row>

                        <v-row v-show="discount" class="ml-3 mb-5" >
                            <v-col cols="6">
                                Discount
                            </v-col>
                            <v-col cols="6">
                                Rp. {{ discount }}
                            </v-col>
                        </v-row>
                        
                        <v-divider></v-divider>
                        <v-row class="ml-3 mt-5 mb-6">
                            <v-col cols="6">
                                Total
                            </v-col>
                            <v-col cols="6">
                                Rp. {{ total }}
                            </v-col>
                        </v-row>

                        <v-row class="ml-5 mr-5 mb-6">
                            <v-btn color="orange" :disabled="checkCart" block @click="dialog=true">Checkout <v-icon>mdi-cart</v-icon></v-btn> 

                        </v-row>
                    </v-container>

                </v-card>
            </v-col>
        </v-row>
        <v-snackbar
            timeout="4000"
            :color="color"
            v-model="snackbar"
            top
            right
        >
            {{ error_message }}
        </v-snackbar>

        <v-dialog v-model="dialog" persistent max-width="400px">
        <v-card>
            <v-card-title class="headline">Are you sure want to checkout ?</v-card-title>
            <v-card-text class="text-center">Please Check your cart again<v-icon>mdi-emoticon-wink-outline</v-icon></v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn  @click="dialog = false" >CANCEL</v-btn>
                <v-btn color="yellow darken-4" class="white--text ml-5" @click="checkOut">PROCESS</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    </v-container>
</template>

<script>
export default {
    data() {
        return {
            overlay:false,
            snackbar:false,
            dialog:false,
            color:"",
            address:'',
            error_message:"",
            subtotal:0,
            discount:0,
            coupon:'',
            total:1000000,
            carts:[]
        }
    },
    methods: {
        deleteCart(item){
            var x= window.confirm("Apa yakin ingin menghapus produk ini dalam keranjang ?");
            if(x){
                this.overlay = true;
                this.$http.delete(this.$api + '/cart/'+item.id,
                {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                    }, 
                }).then(response => {
                    this.error_message =  response.data.message;
                    this.color = "green";
                    this.snackbar = true;    
                    this.getCart();

                }).catch(err => {
                    this.overlay=false;
                    this.error_message =  err.response.data.message;
                    this.color = "red";
                    this.snackbar = true;
                })
            }
            this.hitungTotal();
        },
        min(item,index){
            if(item.quantity-1 <= 0){
                this.deleteCart(item);
            }
            else{
                this.overlay = true;
                this.$http.put(this.$api + '/cart/'+item.id,
                {
                    product_id:item.product_id, 
                    quantity:item.quantity-1,
                    variance:item.variance,
                    subtotal:item.subtotal-item.product.price,
                },
                {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                    }, 
                }).then(response => {
                    this.error_message =  response.data.message;
                    this.color = "green";
                    this.snackbar = true;    
                    var data = response.data.data;
                    this.carts[index].quantity = data.quantity;
                    this.carts[index].subtotal = data.subtotal;
                    this.hitungTotal();
                    this.overlay=false;
                }).catch(err => {
                    console.log(err);
                    this.error_message =  err.response.data.message;
                    this.color = "red";
                    this.snackbar = true;
                    this.overlay=false;
                })
            }
            
        },
        getCart(){
            this.carts = [];
            this.overlay = true;
            this.$http.get(this.$api + '/cart',
            {
                headers: {
                    'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                }, 
            }).then(response => {
                if(response.data.message != "Empty"){
                    for(let i=0 ;i< response.data.data.length;i++){
                        var cartData = response.data.data[i];
                        var cart = {
                            id : cartData.id,
                            quantity:cartData.quantity,
                            product_id:cartData.product_id,
                            subtotal:cartData.subtotal,
                            variance:cartData.variance,
                            product :{
                                name: cartData.product.name,
                                price: cartData.product.price,
                                stock: cartData.product.stock,
                                image: this.$storageUrl+cartData.product.image.split(":")[1].split('"')[1],
                            }
                        }
                        this.carts.push(cart);
                    }
                }else{
                    this.carts = null;
                }
                this.hitungTotal();
                this.overlay = false;
            }).catch(err => {
                this.overlay = false;
                console.log(err.response.message);
                this.carts = null;
            })
        },
        plus(item,index){
            if(item.quantity+1 > item.product.stock){
                this.error_message =  "Telah mencapai maksimal stock";
                this.color = "red";
                this.snackbar = true;
            }
            else{
                this.overlay = true;
                this.$http.put(this.$api + '/cart/'+item.id,
                {
                    product_id:item.product_id, 
                    quantity:parseFloat(item.quantity)+parseFloat(1),
                    variance:item.variance,
                    subtotal:parseFloat(item.subtotal)+parseFloat(item.product.price),
                },
                {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                    }, 
                }).then(response => {
                    this.error_message =  response.data.message;
                    this.color = "green";
                    this.snackbar = true;    
                    var data = response.data.data;
                    this.carts[index].quantity = data.quantity;
                    this.carts[index].subtotal = data.subtotal;
                    this.hitungTotal();
                    this.overlay=false;
                }).catch(err => {
                    this.overlay=false;
                    this.error_message =  err.response.data.message;
                    this.color = "red";
                    this.snackbar = true;
                })
            }
            
        },

        hitungTotal(){
            if(this.carts!=null){
                this.subtotal = this.carts.reduce((a,b) => parseFloat(a)+parseFloat(b.subtotal),0);
            }else{
                this.subtotal = 0;
            }
            this.total = this.subtotal - this.discount;
            if(this.subtotal - this.discount < 0)
                this.total = 0;
        },
        applyCoupon(){
            this.overlay = true;
            this.$http.get(this.$api + '/coupon/'+this.coupon,
            {
                headers: {
                    'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                }, 
            }).then(response => {
                var data = response.data.data;
                this.discount = data.discount;
                this.overlay = false;
                this.hitungTotal();
            }).catch(err => {
                this.overlay = false;
                console.log(err.response.data.message);
                this.carts = null;
            })
        },
        checkOut(){
            if(localStorage.getItem("address")!='null'){
                
                this.overlay = true;
                this.$http.post(this.$api + '/order',
                {
                    grandtotal:this.total,
                    address:this.address
                },
                {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                    }, 
                }).then(response => {
                    this.error_message =  response.data.message;
                    this.color = "green";
                    this.snackbar = true;    
                    this.dialog = false;
                    this.overlay = false;
                    this.$router.push({
                        path:'/my-order'
                    });
                }).catch(err => {
                    this.overlay=false;
                    console.log(err);
                    this.error_message =  err.response.data.message;
                    this.color = "red";
                    this.snackbar = true;
                })
            }else{
                this.error_message =  "Add your address first !";
                this.color = "red";
                this.snackbar = true;
            }
        },
        checkLogin(){
            if(localStorage.getItem("access_token") == null){
                this.$router.push('login');
            }
        },
        setAddress(){
            this.address = localStorage.getItem("name")+" - " + localStorage.getItem("phoneNumber") + "<br>"+localStorage.getItem("address");
        },
    },
    computed:{
        checkCart(){
            if(this.carts!=null &&  this.carts.length>0){
                return false;
            }else{
                return true;
            }
        }
    },
    mounted(){
        this.getCart();
        this.checkLogin();
        this.setAddress();
    },
}
</script>

<style scoped>
    .thumbnail{
        max-height: fit-content;
        max-width: 150px;
    }
</style>