<template>
    <div>
      <h1>Add New Employee</h1>
  
      <div class="container">
        <form @submit.prevent="createEmployee">
            <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

                <div class="mb-3 col">
                    <label for="nomor_induk" class="form-label">NOMOR INDUK</label>
                    <input v-model="newEmployee.nomor_induk" type="text" class="form-control" id="nomor_induk" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="gambar" class="form-label">FOTO GAMBAR</label>
                    <input v-model="newEmployee.gambar" type="text" class="form-control" id="gambar">
                  </div>
                  
                  <div class="mb-3 col">
                    <label for="nama" class="form-label">NAMA</label>
                    <input v-model="newEmployee.nama" type="text" class="form-control" id="nama" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="gender" class="form-label">GENDER</label>
                    <select v-model="newEmployee.gender" class="form-select" id="gender">
                      <option :value="false">Female</option>
                      <option :value="true">Male</option>
                    </select>
                  </div>

                  <div class="mb-3 col">
                    <label for="email" class="form-label">EMAIL</label>
                    <input v-model="newEmployee.email" type="email" class="form-control" id="email" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="telepon" class="form-label">TELEPON</label>
                    <input v-model="newEmployee.telepon" type="tel" class="form-control" id="telepon" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="jabatan" class="form-label">JABATAN</label>
                    <input v-model="newEmployee.jabatan" type="text" class="form-control" id="jabatan" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="divisi" class="form-label">DIVISI</label>
                    <input v-model="newEmployee.divisi" type="text" class="form-control" id="divisi" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="alamat" class="form-label">ALAMAT</label>
                    <textarea v-model="newEmployee.alamat" class="form-control" id="alamat" rows="3" required></textarea>
                  </div>
          
            </div>
            <button type="submit" class="btn btn-primary">Add Employee</button>

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
          newEmployee: {
                nomor_induk: '...',
                gambar: '...',
                nama: '...',
                gender: null,
                email: 'email@gmail.com',
                telepon: '...',
                jabatan: '...',
                divisi: '...',
                alamat: '...',
            },
        };
    },
    mounted() {
    },
    methods: {
        createEmployee() {          
            axios.post('http://localhost:8080/api/employees', [this.newEmployee])
                // eslint-disable-next-line no-unused-vars
                .then(response => {
                    this.newEmployee = [];
                    console.log(response, this.newEmployee)
                    router.push({ path: `/dataKaryawan` });
                })
                .catch(error => {
                    console.error('Error creating inventory:', error);
                });
        },
        fetchEmployees() {
            axios.get('http://localhost:8080/api/employees')
                .then(response => {
                    this.employees = response.data.employees;
                    console.log(response, this.newEmployee)
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
    },
};
</script>
  
<style>

</style>
  