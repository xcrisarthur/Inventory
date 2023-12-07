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
import usageHistory from "@/views/usageHistory.vue";
import InventoryADD from "@/views/InventoryADD.vue";
import InventoryEDIT from "@/views/InventoryEDIT.vue";

const routes = [
  {
    path: "/",
    name: "/",
    redirect: "/dashboard",
  },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: Dashboard,
  },
  {
    path: "/dataAset",
    name: "dataAset",
    component: dataAset,
  },
  {
    path: "/nilaiBuku",
    name: "nilaiBuku",
    component: nilaiBuku,
  },
  {
    path: "/Inventory",
    name: "Inventory",
    component: Inventory,
  },
  {
    path: "/InventoryADD",
    name: "Inventory ADD",
    component: InventoryADD,
  },
  {
    path: '/Inventory/:id', 
    name: 'Edit Inventory',
    component: InventoryEDIT,
  },
  {
    path: "/Room",
    name: "Room",
    component: Room,
  },
  {
    path: "/RoomADD",
    name: "Room ADD",
    component: RoomADD,
  },
  {
    path: '/Room/:id', 
    name: 'Edit Room',
    component: RoomEDIT,
  },
  {
    path: "/Lokasi",
    name: "Lokasi",
    component: Lokasi,
  },
  {
    path: "/LokasiADD",
    name: "Lokasi ADD",
    component: LokasiADD,
  },
  {
    path: '/Lokasi/:id', 
    name: 'Edit Lokasi',
    component: LokasiEDIT,
  },
  {
    path: "/reportHistory",
    name: "reportHistory",
    component: reportHistory,
  },
  {
    path: "/repairHistory",
    name: "repairHistory",
    component: repairHistory,
  },
  {
    path: "/usageHistory",
    name: "usageHistory",
    component: usageHistory,
  },
  {
    path: "/Usage",
    name: "Usage",
    component: Usage,
  },
  {
    path: "/UsageADD",
    name: "Usage ADD",
    component: UsageADD,
  },
  {
    path: '/Usages/:id', 
    name: 'Edit Usage',
    component: UsageEDIT,
  },
  {
    path: "/dataKaryawan",
    name: "dataKaryawan",
    component: dataKaryawan,
  },
  {
    path: "/dataKaryawanADD",
    name: "dataKaryawanADD",
    component: dataKaryawanADD,
  },
  {
    path: '/dataKaryawan/:id', 
    name: 'Edit dataKaryawan',
    component: dataKaryawanEDIT,
  },
  {
    path: "/Kategori",
    name: "Kategori",
    component: Kategori,
  },
  {
    path: "/KategoriADD",
    name: "KategoriADD",
    component: KategoriADD,
  },
  {
    path: '/Kategori/:id', 
    name: 'Edit Kategori',
    component: KategoriEDIT,
  },
  {
    path: "/tables",
    name: "Tables",
    component: Tables,
  },
  {
    path: "/billing",
    name: "Billing",
    component: Billing,
  },
  {
    path: "/virtual-reality",
    name: "Virtual Reality",
    component: VirtualReality,
  },
  {
    path: "/profile",
    name: "Profile",
    component: Profile,
  },
  {
    path: "/rtl-page",
    name: "Rtl",
    component: Rtl,
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

export default router;
