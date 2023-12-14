<template>
  <h1>Add New Damage History</h1>

  <div class="container">
    <form @submit.prevent="createDamage">
        <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

      <div class="mb-3 col">
        <label for="id" class="form-label">ID</label>
        <input v-model="newDamage.id" type="text" class="form-control" id="id" disabled>
      </div>
      <div class="mb-3 col">
        <label for="id_pemakaian" class="form-label">Id Pemakaian</label>
        <input v-model="newDamage.id_pemakaian" type="text" class="form-control" id="id_pemakaian" required>
      </div>
      <div class="mb-3 col">
        <label for="tanggal_kerusakan" class="form-label">Tanggal Kerusakan</label>
        <input v-model="newDamage.tanggal_kerusakan" type="datetime-local" class="form-control" id="tanggal_kerusakan" required>
      </div>
    </div>

      <button type="submit" class="btn btn-primary">Add Category</button>
    </form>
  </div>
</template>
  
<script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        newDamage: {
          id: '',
          id_pemakaian: '',
          tanggal_kerusakan: '',
        },
      };
    },
    methods: {
      createDamage() {
        axios.post('http://localhost:8080/api/problemHistories', this.newDamage)
          // eslint-disable-next-line no-unused-vars
          .then(response => {
            this.newDamage = {};
          })
          .catch(error => {
            console.error('Error creating category:', error);
          });
      },
    },
  };
</script>
  
<style>

</style>