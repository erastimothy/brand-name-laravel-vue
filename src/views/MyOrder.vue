<template >
    <v-container fluid>
        <v-card
            class="mx-auto"
            max-width="800px"
            dark
        >
        <v-card-title class="justify-center headline">
            Order History
        </v-card-title>
        <v-divider></v-divider>
        
        <v-container >
            <v-text-field
                class="ml-auto mr-5 mb-5"
                v-model="search"
                append-icon="mdi-magnify"
                style="width:200px"
                label="search"
                dark
                hide-details>
            </v-text-field>

            <v-spacer></v-spacer>

            <v-data-table
                :headers="headers"
                :items="orders"
                :search="search" 
                light
                pagination.sync="pagination"
                class="elevation-1 mb-6"
            >   
                <template v-slot:[`item.status`]="{ item }">
                    <v-chip
                        :color="getColor(item.status)"
                        dark
                    >
                        {{ item.status }}
                    </v-chip>
                </template>
                <template v-slot:[`item.actions`]="{ item }">
                    <v-btn color="orange darken-3 white--text" class="mr-2" small @click="verifPayment(item)" v-if="item.status =='menunggu pembayaran' ">Confirm payment</v-btn>
                    <v-btn color="blue darken-3 white--text" small @click="viewDetail(item)">view</v-btn>
                </template>
            </v-data-table>
        </v-container>
        </v-card>

        <v-dialog
            v-model="dialogDetails"
            max-width="600px"
            transition="dialog-transition"
        >
            <v-toolbar dense>
                Order detail
                <v-spacer></v-spacer>
                <v-btn
                icon
                right
                @click="dialogDetails = false"
            >
                <v-icon>mdi-close</v-icon>
            </v-btn>
            </v-toolbar>
            <v-data-table
            :headers="headersOrderDetail"
            :items="orderDetail"
            class="elevation-1"
            loading="true"
        >
            
        </v-data-table>
        </v-dialog>

        
        <v-snackbar
            timeout="4000"
            :color="color"
            v-model="snackbar"
            bottom
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
        data: () => ({
            snackbar:false,
            overlay:false,
            color:"",
            error_message:"",
            search:"",
            dialogDetails:false,
            headers: [
                { text: 'No Order', value: 'no_order' },
                { text: 'Date', value: 'date' },
                { text: 'Total', value: 'grandtotal' },
                { text: 'Status', value: 'status' },
                { text: 'Action', value: 'actions' },
            ],
            headersOrderDetail: [
                { text: 'Product', value: 'product' },
                { text: 'Variance', value: 'variance' },
                { text: 'Price', value: 'price' },
                { text: 'Quantity', value: 'quantity' },
                { text: 'Subtotal', value: 'subtotal' },
            ],
            orderDetail: [
                {
                    product: "T-shirt baju",
                    size: "XL",
                    price: 50000,
                    quantity: 1,
                    subtotal:50000,
                },
                {
                    product: "Avenjet T-shirt",
                    size: "XL",
                    price: 95000,
                    quantity: 2,
                    subtotal:190000,
                },
            ],
            orders: [],
            
        }),
    
        methods: {
            getColor(status){
                if(status == "menunggu pembayaran"){
                    return 'yellow darken-4';
                }else if(status == "pesanan diproses"){
                    return 'primary';
                }else if(status == "pesanan selesai"){
                    return 'green';
                }else{
                    return 'red';
                }
            },
            getOrder(){
                this.orders=[];
                this.overlay = true;
                this.$http.get(this.$api + '/order',
                {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                    }, 
                }).then(response => {
                    //console.log(response.data);
                    for(var i =0 ; i< response.data.data.length; i++){
                        var data = response.data;
                        var order = {
                                no_order: data.data[i].no_order,
                                id: data.data[i].id,
                                date: data.data[i].created_at,
                                grandtotal: data.data[i].grandtotal,
                                status: data.data[i].status,
                            };
                        this.orders.push(order);
                    }
                    this.overlay = false;
                }).catch(err => {
                    this.overlay = false;
                    if(err.response.data.message != "Empty"){
                        this.error_message= err.response.data.message;
                        this.snackbar = true;
                        this.color = "red"; 
                    }
                })
            },
            viewDetail(item){
                this.orderDetail=[];
                this.overlay = true;
                this.$http.get(this.$api + '/order-detail/'+item.id,
                {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                    }, 
                }).then(response => {
                    //console.log(response.data);
                    for(var i =0 ; i< response.data.data.length; i++){
                        var data = response.data;
                        var detail =  {
                                product: data.data[i].product.name,
                                variance: data.data[i].variance,
                                price: data.data[i].product.price,
                                quantity: data.data[i].quantity,
                                subtotal:data.data[i].subtotal,
                            };
                        this.orderDetail.push(detail);
                    }
                    this.dialogDetails = true;
                    this.overlay = false;
                }).catch(err => {
                    this.overlay = false;
                    if(err.response.data.message != "Empty"){
                        this.error_message= err.response.data.message;
                        this.snackbar = true;
                        this.color = "red"; 
                    }
                    
                })
            },
            verifPayment(item){
                localStorage.setItem("noOrder",item.no_order);
                localStorage.setItem("order_id",item.id);
                this.$router.push('/confirmation-payment');
            },
            checkLogin(){
                if(localStorage.getItem("access_token") == null){
                    this.$router.push('login');
                }
            },
        },
        mounted(){
            this.checkLogin();
            this.getOrder();
        }
    };
</script>

<style>
</style>