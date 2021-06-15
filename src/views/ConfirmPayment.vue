<template >
    <v-container fluid>
        <v-card
            class="mx-auto"
            max-width="500px"
            dark
        >
        <v-card-title class="justify-center mb-2" >
            Payment Confirmation
        </v-card-title>
        <v-card-text>
            <v-divider></v-divider>
            
            <template>
                <v-text-field
                    label="No Order"
                    v-model="noOrder"
                    readonly
                    solo-inverted
                    hint="No order"
                ></v-text-field>
                <v-file-input
                    accept="image/*"
                    label="Transaction Receipt"
                    v-model="selectedImage"
                ></v-file-input>
                
                <v-btn
                class="mr-4 mb-6 mt-6"
                color="warning"
                block
                @click = "uploadImage"
                >
                submit
                </v-btn>
            </template>
            
        </v-card-text>
        </v-card>

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
        data: () => ({
            overlay:false,
            valid: true,
            showpass:false,
            snackbar:false,
            noOrder:"",
            color:"",
            error_message:"",
            name: "",
            phoneNumber:"",
            selectedImage:null,
        }),
    
        methods: {
            uploadImage(){
                if(this.selectedImage == null) {
                    this.error_message = "Belum pilih filenya";
                    this.snackbar = true;
                    this.color = "red";
                }else {
                
                this.overlay = true;
                let fd = new FormData();
                fd.append('image',this.selectedImage);
                fd.append('order_id',localStorage.getItem('order_id'));
                var url = this.$api + '/confirm-payment';

                this.$http.post(url,fd, 
                {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem('access_token')
                    },
                    
                }).then(response => {
                    this.overlay = false;
                    console.log(response);
                    this.error_message = response.data.message;
                    this.snackbar = true;
                    this.color = "green";
                    this.selectedImage = null;
                }).catch(error => {
                    this.overlay = false;
                    this.error_message = error.response.data.message;
                    this.snackbar = true;
                    this.color = "green";
                })
                }
            },
            checkLogin(){
                if(localStorage.getItem("access_token") == null){
                    this.$router.push('login');
                }
            },
        },
        mounted(){
            this.checkLogin();
            this.noOrder = localStorage.getItem('noOrder');
        }
    };
</script>

<style>
</style>