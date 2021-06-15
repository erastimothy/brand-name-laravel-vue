<template>
    <v-container class="d-flex justify-center">
        <v-card tile width="500px" class="mt-6 mb-6">
            <v-card-title class="justify-center ">
                <h2>REGISTER</h2>
            </v-card-title>
            <v-divider></v-divider>
            <v-card-text>
                <v-form class="ml-6 mr-6 mt-6" ref="form" v-model="valid" lazy-validation>
                    <v-text-field
                        label="Name"
                        prepend-icon="mdi-account"
                        v-model="name"
                        :rules="[rules.requiredRule]"
                        required
                    ></v-text-field>
                    <v-text-field
                        label="E-mail"
                        prepend-icon="mdi-email"
                        v-model="email"
                        :rules="[rules.emailRule, rules.requiredRule]"
                        required
                    ></v-text-field>
                    <v-text-field
                        v-model="phoneNumber"
                        prepend-icon="mdi-phone"
                        :rules="[rules.phoneNumberRule, rules.requiredRule]"
                        type="tel"
                        single-line
                        label="Phone number"
                    ></v-text-field>
                    <v-text-field
                        v-model="password"
                        :append-icon="showpass ? 'mdi-eye' : 'mdi-eye-off'"
                        :rules="[rules.passwordRule, rules.requiredRule]"
                        prepend-icon="mdi-lock"
                        :type="showpass ? 'text' : 'password'"
                        label="Password"
                        @click:append="showpass = !showpass"
                    ></v-text-field>
                    <v-btn block dark tile style="margin-top:2rem;margin-bottom:1rem" @click="register">
                        SIGN UP
                    </v-btn>
                    <div style="margin-bottom:100px;margin-top:50px">
                        Already have account ? <router-link class="black--text" to="/login">Login</router-link>
                    </div>
                    
                </v-form>
            </v-card-text>
        </v-card>

        
        <v-snackbar
            timeout="9000"
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
            valid: true,
            showpass:false,
            color:'',
            snackbar:false,
            error_message:'',
            email: '',
            name: '',
            phoneNumber: '',
            password: '',
            rules :{
                emailRule: v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
                requiredRule: v => !!v || '* Field Required',
                passwordRule: v => (v  && v.length >= 6  )|| 'Min 6 characters',
                phoneNumberRule: v =>(v && v.length >= 8 )|| 'Min 8 digits',
            },
        }
    },
    methods: {
        register(){
            if(this.$refs.form.validate()){
                this.overlay = true;
                this.$http.post(this.$api + '/register',
                { //params
                        name : this.name,
                        email : this.email,
                        password : this.password,
                        phoneNumber : this.phoneNumber,
                
                }).then(response => {
                    this.error_message =  response.data.message;
                    this.color = "green";
                    this.snackbar = true;
                    this.overlay = false;

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