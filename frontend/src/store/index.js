import { createStore } from "vuex";
import bootstrap from "bootstrap/dist/js/bootstrap.min.js";
import axios from "axios";
import router from '../router';

export default createStore({
  state: {
    hideConfigButton: false,
    isPinned: true,
    showConfig: false,
    isTransparent: "",
    isRTL: false,
    color: "",
    isNavFixed: false,
    isAbsolute: false,
    showNavs: true,
    showSidenav: true,
    showNavbar: true,
    showFooter: true,
    showMain: true,
    navbarFixed:
      "position-sticky blur shadow-blur left-auto top-1 z-index-sticky px-0 mx-4",
    absolute: "position-absolute px-4 mx-0 w-100 z-index-2",
    bootstrap,

    isLoggedIn: localStorage.getItem('isLoggedIn') === 'true' || false,

    // For Fetch Data
    DamageHistoryList: [],
    RepairHistoryList: [],
    UsageHistoryList: [],
    rooms: [],
    usages: [],
    categories: [],
    employees: [],
    locations: [],
    inventories: [],
    skills: [],
    portofolios: [],
    skillsEmployee: [],
    portofoliosEmployee: [],
    // For Fetch Data
  },
  mutations: {
    toggleConfigurator(state) {
      state.showConfig = !state.showConfig;
    },
    navbarMinimize(state) {
      const sidenav_show = document.querySelector(".g-sidenav-show");
      if (sidenav_show.classList.contains("g-sidenav-hidden")) {
        sidenav_show.classList.remove("g-sidenav-hidden");
        sidenav_show.classList.add("g-sidenav-pinned");
        state.isPinned = true;
      } else {
        sidenav_show.classList.add("g-sidenav-hidden");
        sidenav_show.classList.remove("g-sidenav-pinned");
        state.isPinned = false;
      }
    },
    sidebarType(state, payload) {
      state.isTransparent = payload;
    },
    cardBackground(state, payload) {
      state.color = payload;
    },
    navbarFixed(state) {
      if (state.isNavFixed === false) {
        state.isNavFixed = true;
      } else {
        state.isNavFixed = false;
      }
    },
    toggleEveryDisplay(state) {
      state.showNavbar = !state.showNavbar;
      state.showSidenav = !state.showSidenav;
      state.showFooter = !state.showFooter;
    },
    toggleHideConfig(state) {
      state.hideConfigButton = !state.hideConfigButton;
    },

    setLoggedIn(state, value) {
      state.isLoggedIn = value;
      localStorage.setItem('isLoggedIn', value); // Save in local storage
    },

    // For Fetch Data
    setDamageHistoryList(state, data) {
      state.DamageHistoryList = data;
    },
    setRepairHistoryList(state, data) {
      state.RepairHistoryList = data;
    },
    setUsageHistoryList(state, data) {
      state.UsageHistoryList = data;
    },
    setRoomsList(state, data) {
      state.rooms = data;
    },
    setUsagesList(state, data) {
      state.usages = data;
    },
    setCategoriesList(state, data) {
      state.categories = data;
    },
    setEmployeesList(state, data) {
      state.employees = data;
    },
    setLocationsList(state, data) {
      state.locations = data;
    },
    setInventoriesList(state, data) {
      state.inventories = data;
    },
    setDamageList(state, data) {
      state.DamageList = data;
    },
    setSkillsList(state, data) {
      state.skills = data;
    },
    setPortofoliosList(state, data) {
      state.portofolios = data;
    },
    setSkillsEmployeeList(state, data) {
      state.skillsEmployee = data;
    },
    setPortofoliosEmployeeList(state, data) {
      state.portofoliosEmployee = data;
    },
    // For Fetch Data
  },
  actions: {
    toggleSidebarColor({ commit }, payload) {
      commit("sidebarType", payload);
    },
    setCardBackground({ commit }, payload) {
      commit("cardBackground", payload);
    },

    async login({ commit }, { email, password }) {
      try {
        const response = await axios.post('http://localhost:8080/login', {
          email,
          password,
        });
        commit('setLoggedIn', true);
        console.log(response)
        router.push({ path: `/dashboard` });
      } catch (error) {
        console.error('Login error:', error);
      }
    },
    logout(state) {
      state.isLoggedIn = false;
      localStorage.removeItem('isLoggedIn'); // Clear from local storage
      // router.push({ path: `/sign-in` });
      window.location.reload();

    },
  

    // For Fetch Data
    async fetchData({ commit }, { endpoint, dataKey, mutation }) {
      try {
        const response = await axios
          .get(`http://localhost:8080/api/${endpoint}`);
        commit(mutation, response.data[dataKey]);
      } catch (error) {
        console.error(`Error fetching ${dataKey}:`, error);
      }
    },
    // For Fetch Data

  },
  getters: {},
});
