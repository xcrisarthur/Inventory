import { createRouter, createWebHistory } from "vue-router";
import Dashboard from "@/views/Dashboard.vue";
import dataAset from "@/views/dataAset.vue";
import nilaiBuku from "@/views/nilaiBuku.vue";
import Inventory from "@/views/Inventory.vue";
import dataKaryawan from "@/views/dataKaryawan.vue";
import dataKaryawanADD from "@/views/dataKaryawanADD.vue";
import dataKaryawanEDIT from "@/views/dataKaryawanEDIT.vue";

import Kategori from "@/views/Kategori.vue";
import KategoriADD from "@/views/KategoriADD.vue";
import KategoriEDIT from "@/views/KategoriEDIT.vue";

import Room from "@/views/Room.vue";
import RoomADD from "@/views/RoomADD.vue";
import RoomEDIT from "@/views/RoomEDIT.vue";

import Lokasi from "@/views/Lokasi.vue";
import LokasiADD from "@/views/LokasiADD.vue";
import LokasiEDIT from "@/views/LokasiEDIT.vue";

import Tables from "@/views/Tables.vue";
import Billing from "@/views/Billing.vue";
import VirtualReality from "@/views/VirtualReality.vue";
import Profile from "@/views/Profile.vue";
import Rtl from "@/views/Rtl.vue";
import SignIn from "@/views/SignIn.vue";
import SignUp from "@/views/SignUp.vue";

import Usage from "@/views/Usage.vue";
import UsageADD from "@/views/UsageADD.vue";
import UsageEDIT from "@/views/UsageEDIT.vue";

import reportHistory from "@/views/reportHistory.vue";

import repairHistory from "@/views/repairHistory.vue";
import repairHistoryADD from "@/views/repairHistoryADD.vue";
import repairHistoryEDIT from "@/views/repairHistoryEDIT.vue";

import damageHistory from "@/views/damageHistory.vue";
import damageHistoryADD from "@/views/damageHistoryADD.vue";
import damageHistoryEDIT from "@/views/damageHistoryEDIT.vue";

import usageHistory from "@/views/usageHistory.vue";
import InventoryADD from "@/views/InventoryADD.vue";
import InventoryEDIT from "@/views/InventoryEDIT.vue";
import store from "@/store/index";

const routes = [
  {
    path: "/",
    name: "/",
    redirect: "/sign-in",
    meta: { requiresAuth: true },
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: Dashboard,
    meta: { requiresAuth: true },
  },
  {
    path: "/dataAset",
    name: "dataAset",
    component: dataAset,
    meta: { requiresAuth: true },
  },
  {
    path: "/nilaiBuku",
    name: "nilaiBuku",
    component: nilaiBuku,
    meta: { requiresAuth: true },
  },
  {
    path: "/Inventory",
    name: "Inventory",
    component: Inventory,
    meta: { requiresAuth: true },
  },
  {
    path: "/InventoryADD",
    name: "Inventory ADD",
    component: InventoryADD,
    meta: { requiresAuth: true },
  },
  {
    path: '/Inventory/:id', 
    name: 'Edit Inventory',
    component: InventoryEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/Room",
    name: "Room",
    component: Room,
    meta: { requiresAuth: true },
  },
  {
    path: "/RoomADD",
    name: "Room ADD",
    component: RoomADD,
    meta: { requiresAuth: true },
  },
  {
    path: '/Room/:id', 
    name: 'Edit Room',
    component: RoomEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/Lokasi",
    name: "Lokasi",
    component: Lokasi,
    meta: { requiresAuth: true },
  },
  {
    path: "/LokasiADD",
    name: "Lokasi ADD",
    component: LokasiADD,
    meta: { requiresAuth: true },
  },
  {
    path: '/Lokasi/:id', 
    name: 'Edit Lokasi',
    component: LokasiEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/reportHistory",
    name: "reportHistory",
    component: reportHistory,
    meta: { requiresAuth: true },
  },
  {
    path: "/repairHistory",
    name: "repairHistory",
    component: repairHistory,
    meta: { requiresAuth: true },
  },
  {
    path: "/repairHistoryADD",
    name: "repairHistoryADD",
    component: repairHistoryADD,
    meta: { requiresAuth: true },
  },
  {
    path: "/repairHistory/:id",
    name: "repairHistoryEDIT",
    component: repairHistoryEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/usageHistory",
    name: "usageHistory",
    component: usageHistory,
    meta: { requiresAuth: true },
  },
  {
    path: "/damageHistory",
    name: "damageHistory",
    component: damageHistory,
    meta: { requiresAuth: true },
  },
  {
    path: "/damageHistoryADD",
    name: "damageHistoryADD",
    component: damageHistoryADD,
    meta: { requiresAuth: true },
  },
  {
    path: "/damageHistory/:id",
    name: "damageHistoryEDIT",
    component: damageHistoryEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/Usage",
    name: "Usage",
    component: Usage,
    meta: { requiresAuth: true },
  },
  {
    path: "/UsageADD",
    name: "Usage ADD",
    component: UsageADD,
    meta: { requiresAuth: true },
  },
  {
    path: '/Usages/:id', 
    name: 'Edit Usage',
    component: UsageEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/dataKaryawan",
    name: "dataKaryawan",
    component: dataKaryawan,
    meta: { requiresAuth: true },
  },
  {
    path: "/dataKaryawanADD",
    name: "dataKaryawanADD",
    component: dataKaryawanADD,
    meta: { requiresAuth: true },
  },
  {
    path: '/dataKaryawan/:id', 
    name: 'Edit dataKaryawan',
    component: dataKaryawanEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/Kategori",
    name: "Kategori",
    component: Kategori,
    meta: { requiresAuth: true },
  },
  {
    path: "/KategoriADD",
    name: "KategoriADD",
    component: KategoriADD,
    meta: { requiresAuth: true },
  },
  {
    path: '/Kategori/:id', 
    name: 'Edit Kategori',
    component: KategoriEDIT,
    meta: { requiresAuth: true },
  },
  {
    path: "/tables",
    name: "Tables",
    component: Tables,
    meta: { requiresAuth: true },
  },
  {
    path: "/billing",
    name: "Billing",
    component: Billing,
    meta: { requiresAuth: true },
  },
  {
    path: "/virtual-reality",
    name: "Virtual Reality",
    component: VirtualReality,
    meta: { requiresAuth: true },
  },
  {
    path: "/profile",
    name: "Profile",
    component: Profile,
    meta: { requiresAuth: true },
  },
  {
    path: "/rtl-page",
    name: "Rtl",
    component: Rtl,
    meta: { requiresAuth: true },
  },
  {
    path: "/sign-in",
    name: "Sign In",
    component: SignIn,
  },
  {
    path: "/sign-up",
    name: "Sign Up",
    component: SignUp,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
  linkActiveClass: "active",
});

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requiresAuth)) {
    if (!store.state.isLoggedIn) {
      next({ name: "Sign In" });
    } else {
      next();
    }
  } else {
    next();
  }
});

export default router;
