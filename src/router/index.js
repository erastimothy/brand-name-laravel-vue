import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '*',
    name: 'Home',
    component: Vue.component("page-not-found", {
      template: "",
      created: function() {
          window.location.href = "/home";
      }
    })
  },
  {
    path: '/home',
    name: 'HomePage',
    component: () => import( '../views/Home.vue')
  },
  {
    path: '/login',
    name: 'LoginPage',
    component: () => import( '../views/Login.vue')
  },
  {
    path: '/register',
    name: 'RegisterPage',
    component: () => import( '../views/Register.vue')
  },
  {
    path: '/category',
    name: 'ShowAllCategory',
    component: () => import( '../views/Category/ShowAll.vue')
  },
  {
    path: '/my-order',
    name: 'MyOrder',
    component: () => import( '../views/MyOrder.vue')
  },
  {
    path: '/confirmation-payment',
    name: 'ConfirmPayment',
    component: () => import( '../views/ConfirmPayment.vue')
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import( '../views/Profile.vue')
  },
  {
    path: '/category/:slug', //dynamic route , show product by category
    name: 'ProductByCategory',
    component: () => import( '../views/Product/ProductByCategory.vue')
  },
  {
    path: '/product/:id', //show product detail
    name: 'ProductDetail',
    component: () => import( '../views/Product/ProductDetail.vue')
  },
  {
    path: '/search/:query', //search product
    name: 'ProductBySearch',
    component: () => import( '../views/Product/ProductBySearch.vue')
  },
  {
    path: '/cart',
    name: 'Cart',
    component: () => import( '../views/Cart.vue')
  },
  // {
  //   path: '/drink',
  //   name: 'Drink',
  //   component: () => import( '../views/Drink.vue')
  // },
  // {
  //   path: '/drinkCard',
  //   name: 'Drink Card',
  //   component: () => import( '../views/DrinkCard.vue')
  // }
]

const router = new VueRouter({
  routes,
  mode: 'history'
})

export default router
