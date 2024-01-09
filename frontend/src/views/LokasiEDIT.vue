<template>
  <div>
      <h1>Edit Location Item</h1>
      <div class="container">
          <form @submit.prevent="updateLocation">
              <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

                  <div class="col form-group">
                      <label for="id_lokasi">ID LOCATION</label>
                      <input v-model="locationItem.id_lokasi" type="text" class="form-control" id="id_lokasi" disabled>
                  </div>

                  <div class="col form-group">
                      <label for="nama">NAMA</label>
                      <input v-model="locationItem.nama" type="text" class="form-control" id="nama" required>
                  </div>

                  <div class="col form-group">
                      <label for="alamat" class="form-label">ALAMAT</label>
                      <input v-model="locationItem.alamat" type="text" class="form-control" id="alamat">
                  </div>

                  <div class="col form-group">
                      <button type="submit" class="btn btn-primary">Update Data</button>
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
          locationItem: {
              id_lokasi: '',
              nama: '',
              alamat: '',
          },
      };
  },
  created() {
      this.FetchLocationItem();
  },
  methods: {
      FetchLocationItem() {
          const itemId = this.$route.params.id;
          axios.get(`http://localhost:8080/api/locations/${itemId}`)
              .then(response => {
                  this.locationItem = response.data.location;
              })
              .catch(error => {
                  console.error('Error fetching locations item:', error);
              });
      },
      updateLocation() {
          axios.put(`http://localhost:8080/api/locations/${this.locationItem.id_lokasi}`, this.locationItem)
              .then(() => {
                  alert('Inventory item updated successfully');
                  router.push({ path: `/Lokasi` });
              })
              .catch(error => {
                  console.error('Error updating inventory item:', error);
              });
      },
  },
};
</script>
  
<style></style>
  