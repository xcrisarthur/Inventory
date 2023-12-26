<template>
    <div>
      <h1>Add New Category</h1>
  
      <div class="container">
        <form @submit.prevent="createCategory">
            <div class="row row-cols-2 row-cols-lg-2 g-lg-3">

          <div class="mb-3 col">
            <label for="id_kategori" class="form-label">Category ID</label>
            <input v-model="newCategory.id_kategori" type="text" class="form-control" id="id_kategori" maxlength="3" required>
          </div>
          <div class="mb-3 col">
            <label for="nama" class="form-label">Category Name</label>
            <input v-model="newCategory.nama" type="text" class="form-control" id="nama" required>
          </div>
        </div>

          <button type="submit" class="btn btn-primary">Add Category</button>
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
        newCategory: {
          id_kategori: '',
          nama: '',
        },
      };
    },
    methods: {
      createCategory() {
        axios.post('http://localhost:8080/api/categories', [this.newCategory])
          // eslint-disable-next-line no-unused-vars
          .then(response => {
            // Handle success, e.g., reset the form
            this.newCategory = {};
            router.push({ path: `/Kategori` });

          })
          .catch(error => {
            console.error('Error creating category:', error);
          });
      },
    },
  };
  </script>
  
  <style>
  /* Add your component-specific styles here */
  </style>
  