<template>
  <div>
    <h1>Usage List</h1>
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
    <table class="table table-striped text-center ">
      <thead>
        <tr>
          <th class="text-uppercase"> Id Pemakaian </th>
          <th class="text-uppercase"> Nama Aset </th>
          <th class="text-uppercase"> Nama Karyawan</th>
          <th class="text-uppercase"> Nama Ruangan </th>
          <th class="text-uppercase"> Status </th>
          <th class="text-uppercase"> Action </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="usage in usages" :key="usage.id_pemakaian">
          <td>{{ usage.id_pemakaian }}</td>
        <td>{{ usage.Inventory.nama }}</td>
        <td>{{ usage.Employee.nama }}</td>
        <td>{{ usage.Room.nama }}</td>
        <td> (( status )) </td>
        <td>
          <button type="button" class="btn btn-warning" @click="redirectToEditPage(usage.id_pemakaian)">Edit</button>
          <button type="button" class="btn btn-danger ms-2" @click="deleteItem(usage.id_pemakaian)">Delete</button>
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
      usages: [],
    };
  },
  mounted() {
    this.fetchUsages();
  },
  methods: {
    fetchUsages() {
      axios.get('http://localhost:8080/api/usages')
        .then(response => {
          this.usages = response.data.usages;
        })
        .catch(error => {
          console.error('Error fetching usages:', error);
        });
    },
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/usages/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
            this.fetchUsages(); // Refresh the items list
          })
          .catch(error => {
            console.error('Error deleting item:', error);
            alert('Failed to delete item.');
          });
      }
    },
    redirectToAddPage() {
      window.location.href = 'http://localhost:8081/UsageAdd';
    },
    redirectToEditPage(itemId) {
      router.push({ path: `/usages/${itemId}` });
    },
  },
};
</script>
