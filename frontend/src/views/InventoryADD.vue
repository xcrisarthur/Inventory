<template>
    <div>
        <h1>Inventory Add</h1>

        <div class="container">
            <form @submit.prevent="createInventory">
                <div class="row row-cols-2 row-cols-lg-4 g-lg-3">
                    <div class="col">
                        <div class="">
                            <label for="kode_aset" class="form-label">Kode aset</label>
                            <input v-model="newInventory.kode_aset" type="text" class="form-control" id="kode_aset" >
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="merk" class="form-label">Merk</label>
                            <input v-model="newInventory.merk" type="text" class="form-control" id="merk">
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="nama" class="form-label">Name</label>
                            <input v-model="newInventory.nama" type="text" class="form-control" id="nama">
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="tanggal" class="form-label">Tanggal</label>
<input v-model="newInventory.tanggal" type="datetime-local" class="form-control" id="tanggal">

                            <!-- <input v-model="newInventory.tanggal" type="text" class="form-control" id="tanggal"> -->
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="harga" class="form-label">Harga</label>
                            <input v-model="newInventory.harga" type="number" class="form-control" id="harga">
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="nilai_residu" class="form-label">Nilai Residu</label>
                            <input v-model="newInventory.nilai_residu" type="number" class="form-control" id="nilai_residu">
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="masa_manfaat" class="form-label">Masa Manfaat</label>
                            <input v-model="newInventory.masa_manfaat" type="number" class="form-control" id="masa_manfaat">
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="depresiasi" class="form-label">Depresiasi</label>
                            <input v-model="newInventory.depresiasi" type="number" class="form-control" id="depresiasi"
                                readonly>
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="deskripsi" class="form-label">Deskripsi</label>
                            <input v-model="newInventory.deskripsi" type="text" class="form-control" id="deskripsi">
                        </div>
                    </div>

                    <!-- <div class="col">
                        <div class=""><label for="status" class="form-label">Status</label>
                            <input v-model="newInventory.status" type="text" class="form-control" id="status">
                        </div>
                    </div> -->

                    <div class="col">
                        <div class=""><label for="id_kategori" class="form-label">Kategori</label>
                            <select v-model="newInventory.id_kategori" class="form-select" id="id_kategori">
                                <option v-for="category in categories" :value="category.id_kategori"
                                    :key="category.id_kategori">
                                    {{ category.nama }}
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="tahun_1" class="form-label">Tahun 1</label>
                            <input v-model="newInventory.tahun_1" type="number" class="form-control" id="tahun_1" readonly>
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="tahun_2" class="form-label">Tahun 2</label>
                            <input v-model="newInventory.tahun_2" type="number" class="form-control" id="tahun_2" readonly>
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="tahun_3" class="form-label">Tahun 3</label>
                            <input v-model="newInventory.tahun_3" type="number" class="form-control" id="tahun_3" readonly>
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="tahun_4" class="form-label">Tahun 4</label>
                            <input v-model="newInventory.tahun_4" type="number" class="form-control" id="tahun_4" readonly>
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="img_url" class="form-label">Img URL</label>
                            <input v-model="newInventory.img_url" type="text" class="form-control" id="img_url">
                        </div>
                    </div>

                    <div class="col">
                        <div class=""><label for="vendor" class="form-label">Vendor</label>
                            <input v-model="newInventory.vendor" type="text" class="form-control" id="vendor">
                        </div>
                    </div>

                    <div class="col">
                        <button type="submit" class="btn btn-primary">Add Data</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>
  
<script>
import axios from 'axios';
import router from '../router';

export default {
    data() {
        return {
            newInventory: {
                kode_aset: '',
                merk: '',
                nama: '',
                tanggal: '',
                harga: 0,
                nilai_residu: 0,
                masa_manfaat: 0,
                depresiasi: 0,
                deskripsi: '',
                status: '',
                id_kategori: 'SPL',
                tahun_1: 0,
                tahun_2: 0,
                tahun_3: 0,
                tahun_4: 0,
                img_url: '',
                vendor: '',
            },
            inventory: [],
            categories: [],
            employees: [],
            rooms: [],

        };
    },
    mounted() {
        this.fetchInventory();
        this.fetchCategories();
        this.fetchEmployees();
        this.fetchRooms();
    },
    methods: {
        fetchInventory() {
            axios.get('http://localhost:8080/api/inventories')
                .then(response => {
                    this.inventory = response.data.Inventory;
                })
                .catch(error => {
                    console.error('Error fetching inventory:', error);
                });
        },

        fetchCategories() {
            axios.get('http://localhost:8080/api/categories')
                .then(response => {
                    this.categories = response.data.categories;
                })
                .catch(error => {
                    console.error('Error fetching categories:', error);
                });
        },
        fetchEmployees() {
            axios.get('http://localhost:8080/api/employees')
                .then(response => {
                    this.employees = response.data.employees;
                })
                .catch(error => {
                    console.error('Error fetching employees:', error);
                });
        },
        fetchRooms() {
            axios.get('http://localhost:8080/api/rooms')
                .then(response => {
                    this.rooms = response.data.rooms;
                })
                .catch(error => {
                    console.error('Error fetching rooms:', error);
                });
        },
        createInventory() {
            axios.post('http://localhost:8080/api/inventories', this.newInventory)
                // eslint-disable-next-line no-unused-vars
                .then(response => {
                    this.fetchInventory();
                    this.newInventory = {};
                    router.push({ path: `/Inventory` });

                    // console.log("response", response)
                    // console.log(this.fetchInventory())
                })
                .catch(error => {
                    console.error('Error creating inventory:', error);
                });
        },
    },
};
</script>
  
<style></style>
  
