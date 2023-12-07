<template>
  <div>
    <h1>Category List</h1>
    <div class="d-flex flex-row mb-3">
      <!-- <div class="p-2">
        <button type="button" class="btn btn-primary">Detail</button>
      </div> -->
      <div class="p-2">
        <button type="button" class="btn btn-secondary">Dowload as PDF</button>
      </div>
      <!-- <div class="p-2">
        <button type="button" class="btn btn-secondary">Primary</button>
      </div> -->
      <div class="p-2 ms-auto me-5">
        <button type="button" class="btn btn-success" @click="redirectToAddPage">Add Data</button>
      </div>
    </div>
    <table class="table table-striped text-center">
      <thead>
        <tr>
          <th class="text-uppercase"> Id kategori </th>
          <th class="text-uppercase"> Nama Kategori </th>
          <th class="text-uppercase"> Action </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="categorie in categories" :key="categorie.id_ruangan">
          <td>{{ categorie.id_kategori }}</td>
        <td>{{ categorie.nama }}</td>
        <td>
          <button type="button" class="btn btn-warning" @click="redirectToEditPage(categorie.id_kategori)">Edit</button>
          <button type="button" class="btn btn-danger ms-2" @click="deleteItem(categorie.id_kategori)">Delete</button>
        </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';
import router from '../router';

export default {
  data() {
    return {
      categories: [],
    };
  },
  mounted() {
    this.fetchCategories();
  },
  methods: {
    fetchCategories() {
      axios.get('http://localhost:8080/api/categories')
        .then(response => {
          this.categories = response.data.categories;
        })
        .catch(error => {
          console.error('Error fetching categories:', error);
        });
    },
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/categories/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
            this.fetchCategories(); // Refresh the items list
          })
          .catch(error => {
            console.error('Error deleting item:', error);
            alert('Failed to delete item.');
          });
      }
    },
    redirectToAddPage() {
      window.location.href = 'http://localhost:8081/KategoriAdd';
    },
    redirectToEditPage(itemId) {
      router.push({ path: `/Kategori/${itemId}` });
    },
  },
};
</script>
