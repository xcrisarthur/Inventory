<template>
  <div>
      <h1>Lokasi Add DATA</h1>
      <div class="container">
          <form @submit.prevent="createLocation">
              <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                  <div class="col">
                      <div class="">
                          <label for="id_lokasi" class="form-label">Id Lokasi</label>
                          <input v-model="newLocation.id_lokasi" type="text" class="form-control" id="id_lokasi" required>
                      </div>
                  </div>

                  <div class="col">
                      <div class="">
                          <label for="nama" class="form-label">Nama</label>
                          <input v-model="newLocation.nama" type="text" class="form-control" id="nama" required>
                      </div>
                  </div>

                  <div class="col">
                    <div class="">
                        <label for="alamat" class="form-label">Alamat</label>
                        <input v-model="newLocation.alamat" type="text" class="form-control" id="alamat" required>
                    </div>
                </div>

                  <div class="col">
                      <button type="submit" class="btn btn-primary">Add Data</button>
                  </div>
              </div>
          </form>
      </div>
  </div>
</template>


<script>
import axios from 'axios';

export default {
  data() {
      return {
          newLocation: {
              id_lokasi: '',
              nama: '',
              alamat: '',
          },
          locations: [],
      };
  },
  mounted() {
      this.fetchLocations();
  },
  methods: {
    createLocation() {
          axios.post('http://localhost:8080/api/locations', this.newLocation)
              // eslint-disable-next-line no-unused-vars
              .then(response => {
                  this.newLocation = {};
              })
              .catch(error => {
                  console.error('Error creating inventory:', error);
              });
      },
      fetchLocations() {
          axios.get('http://localhost:8080/api/locations')
              .then(response => {
                  this.locations = response.data.locations;
              })
              .catch(error => {
                  console.error('Error fetching location:', error);
              });
      },
  },
};
</script>

<style></style>