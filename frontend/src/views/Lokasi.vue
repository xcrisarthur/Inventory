<template>
    <div>
      <h1>Location List</h1>
      <div class="d-flex flex-row mb-3">
        <div class="p-2">
          <button type="button" class="btn btn-secondary">Dowload as PDF</button>
        </div>
        <div class="p-2 ms-auto me-5">
          <button type="button" class="btn btn-success" @click="redirectToAddPage">Add Data</button>
        </div>
      </div>
      <table class="table table-striped text-center">
        <thead>
          <tr>
            <th class="text-uppercase"> Id Lokasi </th>
            <th class="text-uppercase"> Nama </th>
            <th class="text-uppercase"> Alamat </th>
            <th class="text-uppercase"> Action </th>

          </tr>
        </thead>
        <tbody>
          <tr v-for="location in locations" :key="location.id_lokasi">
            <td>{{ location.id_lokasi }}</td>
            <td>{{ location.nama }}</td>
            <td>{{ location.alamat }}</td>
            <td>
              <button type="button" class="btn btn-warning" @click="redirectToEditPage(location.id_lokasi)">Edit</button>
              <button type="button" class="btn btn-danger ms-2" @click="deleteItem(location.id_lokasi)">Delete</button>
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
        locations: [],
      };
    },
    mounted() {
      this.fetchLocations();
    },
    methods: {
      fetchLocations() {
        axios.get('http://localhost:8080/api/locations')
          .then(response => {
            this.locations = response.data.locations;
          })
          .catch(error => {
            console.error('Error fetching locations:', error);
          });
      },
      deleteItem(itemId) {
        if (confirm('Are you sure you want to delete this item?')) {
          axios.delete(`http://localhost:8080/api/locations/${itemId}`)
            .then(() => {
              alert('Item successfully deleted.');
              this.fetchLocations();
            })
            .catch(error => {
              console.error('Error deleting item:', error);
              alert('Failed to delete item.');
            });
        }
      },
      redirectToAddPage() {
        window.location.href = 'http://localhost:8081/LokasiADD';
      },
      redirectToEditPage(itemId) {
        router.push({ path: `/lokasi/${itemId}` });
      },
    },
  };
  </script>
  