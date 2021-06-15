<template >
    <v-container fluid>
        <v-card
            class="mx-auto mt-6 mb-6"
            max-width="500px"
            tile
        >
        <v-card-title class="justify-center" >
            My Account
        </v-card-title>
        <v-card-text>
            <v-divider></v-divider>
            <div class="d-flex justify-center mt-6">
                <img :src="user.avatar" alt="Profile Image" width="100px" height="100px">
            </div>
            <div class="mx-auto d-flex" style="width:300px">
                <v-file-input
                    accept="image/png, image/jpeg, image/bmp"
                    placeholder="upload new avatar"
                    hide-details
                    class="mx-auto mb-6 mt-2"
                    prepend-icon="mdi-camera"
                    label="Avatar"
                    @change="imageSelect"
                ></v-file-input>    
                <v-btn class="mt-6 ml-3 mb-6 mx-auto" color="success" @click="uploadImage" small><v-icon>mdi-upload</v-icon></v-btn>
            </div>
            
            
            <template>
                <v-form v-model="valid" ref="form" lazy-validation class="mt-6">
                    <v-text-field
                        label="E-mail"
                        v-model="user.email"
                        readonly
                        solo-inverted
                        hint="Email"
                    ></v-text-field>
                    <v-text-field
                        label="Name"
                        v-model="user.name"
                        :rules="nameRules"
                        solo-inverted
                        required
                        hint="Name"
                    ></v-text-field>
                     <v-text-field
                        label="phoneNumber"
                        v-model="user.phoneNumber"
                        solo-inverted
                        min="6"
                        max="14"
                        hint="Phone number"
                        required
                    ></v-text-field>
                    <v-textarea
                        v-model="user.address"
                        filled
                        label="Address"
                        hint="your address "
                        rows="4"
                    > </v-textarea>
                    <v-text-field
                        v-model="user.password"
                        :append-icon="showpass ? 'mdi-eye' : 'mdi-eye-off'"
                        :type="showpass ? 'text' : 'password'"
                        label="Password"
                        hint="leave it blank if dont want to change password"
                        @click:append="showpass = !showpass"
                        solo-inverted
                    ></v-text-field>
                    <v-btn
                    class="mr-4 mb-6 mt-6"
                    @click="submit"
                    color="warning"
                    >
                    save
                    </v-btn>
                </v-form>
            </template>
            
            <!--
            
            -->
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
            valid: true,
            showpass:false,
            snackbar:false,
            overlay:false,
            color:"",
            error_message:"",
            name: "",
            phoneNumber:"",
            user: {
                email: 'useremail@email.com',
                name : 'nama user',
                phoneNumber : '08982866621',
                address : 'lorem ipsum dolor sit amet lbla',
                password: '',
                },
            nameRules: [v => !!v || "Name is required"],
            select: null,
            items: ["Item 1", "Item 2", "Item 3", "Item 4"],
            checkbox: false
        }),
    
        methods: {
            imageSelect(e){
                let reader = new FileReader();
                this.selectedImage = e;
                reader.readAsDataURL(e);
                reader.onload = e => {
                    this.user.avatar = e.target.result;
                }
            },
            uploadImage(){
                if(this.selectedImage == null) {
                    this.error_message = "Belum pilih fotonya";
                    this.snackbar = true;
                    this.color = "red";
                }else {
                this.overlay = true;
                let fd = new FormData();
                fd.append('image',this.selectedImage);
                var url = "http://paw.erastimothy.tech/api" + '/uploadImageProfile/'+localStorage.getItem("user_id");
                this.$http.post(url,fd, {
                    headers: {
                        'Authorization' : 'Bearer ' + localStorage.getItem("access_token")
                    },
                    
                }).then(response => {
                    this.imageProfile = response.data.user.image_profile;
                    this.error_message = response.data.message;
                    this.snackbar = true;
                    this.color = "green";
                    this.selectedImage = null;
                    this.overlay = false;
                }).catch(error => {
                    this.overlay = false;
                    console.log(error);
                })
                }
            },
            submit() {
                this.overlay = true;
                this.$http.put(this.$api + '/user/'+localStorage.getItem("user_id"),
                {
                    name:this.user.name,
                    phoneNumber:this.user.phoneNumber,
                    password:this.user.password,
                    address:this.user.address
                },
                {
                    headers:{ 
                        'Authorization' : 'Bearer ' + localStorage.getItem("access_token")
                    }
                }).then(response => {
                    this.error_message = response.data.message;
                    this.snackbar = true;
                    this.color = "green";
                    this.overlay = false;
                    localStorage.setItem("name",response.data.data.name);
                    localStorage.setItem("phoneNumber",response.data.data.phoneNumber);
                    localStorage.setItem("address",response.data.data.address);
                }).catch(err => {
                    this.overlay = false;
                    console.log(err.response);
                })
            },

            getUser(){
                this.overlay = true;
                this.$http.get(this.$api + '/user',
                {
                    headers:{ 
                        'Authorization' : 'Bearer ' + localStorage.getItem("access_token")
                    }
                }).then(response => {
                    this.overlay = false;
                    this.user = {
                        name : response.data.name,
                        phoneNumber: response.data.phoneNumber,
                        email: response.data.email,
                        avatar: this.$storageUrl+response.data.avatar,
                        address:response.data.address,
                    }
                }).catch(err => {
                    this.overlay = false;
                    console.log(err.response);
                })
            },
            checkLogin(){
                if(localStorage.getItem("access_token") == null){
                    this.$router.push('login');
                }
            },
        },
        mounted(){
            this.getUser();
            this.checkLogin();
        }
    };
</script>

<style>
</style>