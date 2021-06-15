<template>
    <v-container class="d-flex justify-center">
        <v-card tile width="500px" class="mt-6 mb-6">
            <v-card-title class="justify-center ">
                <h2>LOGIN</h2>
            </v-card-title>
            <v-divider></v-divider>
            <v-card-text>
                <v-form class="ml-6 mr-6 mt-6" v-model="valid" lazy-validation ref="form"> 
                    <v-text-field
                        label="E-mail"
                        v-model="email"
                        :rules="emailRules"
                        prepend-icon="mdi-email"
                        required
                        class="mb-6"
                    ></v-text-field>
                    <v-text-field
                        v-model="password"  
                        :append-icon="showpass ? 'mdi-eye' : 'mdi-eye-off'"
                        :rules="passwordRules   "
                        :type="showpass ? 'text' : 'password'"
                        prepend-icon="mdi-lock"
                        label="Password"
                        class="mb-6"
                        @click:append="showpass = !showpass"
                    ></v-text-field>
                    <v-btn block dark tile class="mt-6 mb-6" @click="login">
                        SIGN IN
                    </v-btn>
                    <div style="margin-bottom:100px;margin-top:50px">
                        Doesn't have account yet ? <router-link class="black--text" to="/register">Register</router-link>
                    </div>
                    
                </v-form>
            </v-card-text>
        </v-card>

        
        <v-snackbar
            timeout="4000"
            :color="color"
            v-model="snackbar"
            right
            top
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
    data() {
        return {
            overlay:false,
            valid:true,
            showpass:false,
            color:'',
            snackbar:false,
            error_message:'',
            email: '',
            password: '',
            emailRules: [
                v => !!v || 'E-mail is required',
                v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
            ],
            passwordRules: [
                v => !!v || 'Required.',
                v => (v && v.length >= 6) || 'Min 6 characters',
            ],
        }
    },
    methods: {
        login(){
            if(this.$refs.form.validate()){
                this.overlay = true;
                this.$http.post(this.$api + '/login',
                { //params
                        email : this.email,
                        password : this.password,
                }).then(response => {
                    localStorage.setItem("access_token",response.data.access_token);
                    localStorage.setItem("user_id",response.data.data.id);
                    localStorage.setItem("name",response.data.data.name);
                    localStorage.setItem("email",response.data.data.email);
                    localStorage.setItem("phoneNumber",response.data.data.phoneNumber);
                    localStorage.setItem("address",response.data.data.address);
                    localStorage.setItem("avatar",response.data.data.avatar);

                    this.error_message =  response.data.message;
                    this.color = "green";
                    this.snackbar = true;
                    console.log(response);
                    this.overlay = false;
                    window.location.href = "/home";
                }).catch(err => {
                    this.overlay = false;
                    this.error_message =  err.response.data.message;
                    this.color = "red";
                    this.snackbar = true;
                })
                this.$refs.form.reset();
            }
        },
        checkLogin(){
            if(localStorage.getItem("access_token") != null){
                this.$router.push('home');
            }
        },
    },

    mounted(){
        this.checkLogin();
    },
}
</script>

<style scoped>
</style>