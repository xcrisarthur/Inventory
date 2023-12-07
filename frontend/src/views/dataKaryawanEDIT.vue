<template>
    <div>
      <h1>Edit Employees Item</h1>
      <div class="container">
        <form @submit.prevent="updateEmployees">
  
            <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

                <div class="mb-3 col">
                    <label for="nomor_induk" class="form-label">Nomor Induk</label>
                    <input v-model="employeeItem.nomor_induk" type="text" class="form-control" id="nomor_induk" disabled>
                  </div>

                  <div class="mb-3 col">
                    <label for="gambar" class="form-label">Foto Gambar</label>
                    <input v-model="employeeItem.gambar" type="text" class="form-control" id="gambar">
                  </div>
                  
                  <div class="mb-3 col">
                    <label for="nama" class="form-label">Nama</label>
                    <input v-model="employeeItem.nama" type="text" class="form-control" id="nama" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="gender" class="form-label">Gender</label>
                    <select v-model="employeeItem.gender" class="form-select" id="gender">
                      <option :value="true">Female</option>
                      <option :value="false">Male</option>
                    </select>
                  </div>
                  

                  <div class="mb-3 col">
                    <label for="email" class="form-label">Email</label>
                    <input v-model="employeeItem.email" type="email" class="form-control" id="email" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="telepon" class="form-label">telepon</label>
                    <input v-model="employeeItem.telepon" type="tel" class="form-control" id="telepon" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="jabatan" class="form-label">jabatan</label>
                    <input v-model="employeeItem.jabatan" type="text" class="form-control" id="jabatan" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="divisi" class="form-label">divisi</label>
                    <input v-model="employeeItem.divisi" type="text" class="form-control" id="divisi" required>
                  </div>

                  <div class="mb-3 col">
                    <label for="alamat" class="form-label">alamat</label>
                    <textarea v-model="employeeItem.alamat" class="form-control" id="alamat" rows="3" required></textarea>
                  </div>
          
            </div>
            <button type="submit" class="btn btn-primary">Update Employee</button>
        </form>
      </div>
    </div>
  </template>
    
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        employeeItem: {
            nomor_induk: '',
                gambar: '',
                nama: '',
                gender: null,
                email: '',
                telepon: '',
                jabatan: '',
                divisi: '',
                alamat: '',
        },
      };
    },
    created() {
      this.fetchEmployeesItem();
    },
    methods: {
      fetchEmployeesItem() {
        const itemId = this.$route.params.id;
        axios.get(`http://localhost:8080/api/employees/${itemId}`)
          .then(response => {
            this.employeeItem = response.data.employee;
          })
          .catch(error => {
            console.error('Error fetching employees item:', error);
          });
      },
      updateEmployees() {
        axios.put(`http://localhost:8080/api/employees/${this.employeeItem.nomor_induk}`, this.employeeItem)
          .then(() => {
            // Handle successful update
            alert('Inventory item updated successfully');
          })
          .catch(error => {
            console.error('Error updating inventory item:', error);
          });
      },
    },
  };
  </script>
    
  <style></style>
    