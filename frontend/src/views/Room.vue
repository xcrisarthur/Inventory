<template>
  <div>
    <h1>Room List</h1>
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
          <th class="text-uppercase"> Id Ruangan </th>
          <th class="text-uppercase"> Nama Ruangan </th>
          <th class="text-uppercase"> Lokasi </th>
          <th class="text-uppercase"> Action </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="room in rooms" :key="room.id_ruangan">
          <td>{{ room.id_ruangan }}</td>
          <td>{{ room.nama }}</td>
          <td>{{ room.Location.nama }}</td>

          <td>
            <button type="button" class="btn btn-warning" @click="redirectToEditPage(room.id_ruangan)">Edit</button>
            <button type="button" class="btn btn-danger ms-2" @click="deleteItem(room.id_ruangan)">Delete</button>
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
      rooms: [],
    };
  },
  mounted() {
    this.fetchRooms();
  },
  methods: {
    fetchRooms() {
      axios.get('http://localhost:8080/api/rooms')
        .then(response => {
          this.rooms = response.data.rooms;
        })
        .catch(error => {
          console.error('Error fetching rooms:', error);
        });
    },
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/rooms/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
            this.fetchRooms(); // Refresh the items list
          })
          .catch(error => {
            console.error('Error deleting item:', error);
            alert('Failed to delete item.');
          });
      }
    },
    redirectToAddPage() {
      window.location.href = 'http://localhost:8081/RoomADD';
    },
    redirectToEditPage(itemId) {
      router.push({ path: `/room/${itemId}` });
    },
  },
};
</script>
