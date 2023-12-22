<template>
    <div>
      <h1>Add New Employee</h1>
  
      <div class="container">
        <form @submit.prevent="createEmployee">
            <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

                <div class="mb-3 col">
                    <label for="nomor_induk" class="form-label">Nomor Induk</label>
                    <input v-model="newEmployee.nomor_induk" type="text" class="form-control" id="nomor_induk" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="gambar" class="form-label">Foto Gambar</label>
                    <input v-model="newEmployee.gambar" type="text" class="form-control" id="gambar">
                  </div>
                  
                  <div class="mb-3 col">
                    <label for="nama" class="form-label">Nama</label>
                    <input v-model="newEmployee.nama" type="text" class="form-control" id="nama" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="gender" class="form-label">Gender</label>
                    <select v-model="newEmployee.gender" class="form-select" id="gender">
                      <option :value="true">Female</option>
                      <option :value="false">Male</option>
                    </select>
                  </div>
                  

                  <div class="mb-3 col">
                    <label for="email" class="form-label">Email</label>
                    <input v-model="newEmployee.email" type="email" class="form-control" id="email" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="telepon" class="form-label">telepon</label>
                    <input v-model="newEmployee.telepon" type="tel" class="form-control" id="telepon" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="jabatan" class="form-label">jabatan</label>
                    <input v-model="newEmployee.jabatan" type="text" class="form-control" id="jabatan" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="divisi" class="form-label">divisi</label>
                    <input v-model="newEmployee.divisi" type="text" class="form-control" id="divisi" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="alamat" class="form-label">alamat</label>
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
                    this.newEmployee = {};
                    console.log(response, this.newEmployee)
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
  