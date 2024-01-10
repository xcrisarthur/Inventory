<template>
  <main class="main-content mt-0 vh-100" style="">
    <section>
      <div class="page-header min-vh-75">
        <div class="container ">

          <div class="card m-auto mt-8 p-3 " style="width: 30%">
            <div class="card-body ">
              <h3 class="card-title text-dark text-center">S I G N &nbsp; I N</h3>
              <form @submit.prevent="login">

                <div class="inputContainer wave-group my-4">
                  <svg class="inputIcon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#2e2e2e"
                    viewBox="0 0 16 16">
                    <path
                      d="M13.106 7.222c0-2.967-2.249-5.032-5.482-5.032-3.35 0-5.646 2.318-5.646 5.702 0 3.493 2.235 5.708 5.762 5.708.862 0 1.689-.123 2.304-.335v-.862c-.43.199-1.354.328-2.29.328-2.926 0-4.813-1.88-4.813-4.798 0-2.844 1.921-4.881 4.594-4.881 2.735 0 4.608 1.688 4.608 4.156 0 1.682-.554 2.769-1.416 2.769-.492 0-.772-.28-.772-.76V5.206H8.923v.834h-.11c-.266-.595-.881-.964-1.6-.964-1.4 0-2.378 1.162-2.378 2.823 0 1.737.957 2.906 2.379 2.906.8 0 1.415-.39 1.709-1.087h.11c.081.67.703 1.148 1.503 1.148 1.572 0 2.57-1.415 2.57-3.643zm-7.177.704c0-1.197.54-1.907 1.456-1.907.93 0 1.524.738 1.524 1.907S8.308 9.84 7.371 9.84c-.895 0-1.442-.725-1.442-1.914z">
                    </path>
                  </svg>
                  <input type="text" id="email" v-model="email" class="inputField" placeholder="Email">
                </div>

                <div class="inputContainer wave-group my-4">
                  <svg class="inputIcon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#2e2e2e"
                    viewBox="0 0 16 16">
                    <path
                      d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z">
                    </path>
                  </svg>
                  <input type="password" class="inputField" id="password" v-model="password" placeholder="Password">
                </div>
                <div class="text-center">
                  <button type="submit" class="btn w-100 mt-4 mb-0 text-light"
                    style="background-color: #CE3534; font-weight: bolder">L o g i n</button>
                </div>
              </form>
              <div>
                <button type="button" class="btn w-100 btn-success mt-2" @click="redirectPage()">Don't have an account?
                  register here</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
const body = document.getElementsByTagName("body")[0];
import { mapMutations } from "vuex";
import router from "../router";
export default {
  data() {
    return {
      email: '2172003@maranatha.ac.id',
      password: 'David123*#',
    };
  },
  created() {
    if (this.$store.state.isLoggedIn) {
      this.$router.push({ name: 'Dashboard' });
    }
    this.toggleEveryDisplay();
    this.toggleHideConfig();
    body.classList.remove("bg-gray-100");
  },
  beforeUnmount() {
    this.toggleEveryDisplay();
    this.toggleHideConfig();
    body.classList.add("bg-gray-100");
  },
  methods: {
    ...mapMutations(["toggleEveryDisplay", "toggleHideConfig"]),
    async login() {
      try {
        await this.$store.dispatch('login', {
          email: this.email,
          password: this.password,
        });
      } catch (error) {
        console.error('Login error:', error);
      }
    },
    redirectPage() {
      router.push({ path: `/sign-up` });
    },
  },
};
</script>

<style scoped> 
main {
   background-image: url(../assets/img/bgLogin.jpg);
   background-size: cover;
   background-position: center;
 }

 .inputContainer {
   width: 100%;
   position: relative;
   display: flex;
   align-items: center;
   justify-content: center;
   z-index: 2;
 }

 .inputIcon {
   position: absolute;
   left: 3px;
 }

 .inputField {
   width: 100%;
   height: 30px;
   background-color: transparent;
   border: none;
   border-bottom: 2px solid rgb(173, 173, 173);
   margin: 10px 0;
   color: black;
   font-size: .8em;
   font-weight: 500;
   box-sizing: border-box;
   padding-left: 30px;
 }

 .inputField:focus {
   outline: none;
   border-bottom: 2px solid rgb(199, 114, 255);
 }

 .inputField::placeholder {
   color: rgb(80, 80, 80);
   font-size: 1em;
   font-weight: 500;
 }</style>