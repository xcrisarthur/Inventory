<template>
  <div>
    <h1>Location List</h1>
    <div class="d-flex flex-row mb-3">
      <div class="p-2">
        <div class="input-group">
          <input type="file" class="form-control" id="inputGroupFile04" accept=".csv" @change="handleFileChange" />
          <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop"
            aria-controls="offcanvasTop" :disabled="!fileSelected">Preview</button>
          <button class="btn btn-success rounded-end text-dark" type="button" :disabled="!fileSelected"
            @click="addDataToDatabase">ADD</button>
          <div class="offcanvas offcanvas-top h-100" tabindex="-1" id="offcanvasTop" aria-labelledby="offcanvasTopLabel">
            <div class="offcanvas-header">
              <h2 class="offcanvas-title m-auto" id="offcanvasTopLabel">Preview Data From CSV</h2>
              <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas" aria-label="Close">
                <svg
                  xmlns="http://www.w3.org/2000/svg" height="16" width="12" viewBox="0 0 384 512">
                  <path
                    d="M342.6 150.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 210.7 86.6 105.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L146.7 256 41.4 361.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L192 301.3 297.4 406.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L237.3 256 342.6 150.6z" />
                </svg>
              </button>
            </div>
            <div class="offcanvas-body">
              <!-- Preview File di Csv -->
              <div class="text-center">
                <table class="table table-striped table-hover border text-center mx-auto" style="font-size: 16px;">
                  <thead>
                    <tr>
                      <th>Id lokasi</th>
                      <th>Nama</th>
                      <th>Alamat</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="location in filteredLocationsCsv" :key="location.kode_aset">
                      <td>{{ location.id_lokasi }}</td>
                      <td>{{ location.nama }}</td>
                      <td>{{ location.alamat }}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- Preview File di Csv -->
            </div>
          </div>
        </div>
      </div>
      <div class="p-2 ms-auto">
        <div class="input-group flex-nowrap">
          <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
          <input v-model="searchText" @input="filterItems" type="text" class="form-control"
            placeholder="Search Location..." aria-label="Username" aria-describedby="addon-wrapping" />
        </div>
      </div>
      <div class="p-2 me-5">
        <button type="button" class="btn btn-success" @click="redirectToAddPage">Add Data</button>
      </div>
    </div>
    <div class="container text-center">
      <div class="row align-items-start">
        <div class="col">
          <p class="fw-bold fs-4">F I L T E R</p>
        </div>
        <div class="col">
          <select v-model="selectedName" class="form-select" aria-label="Default select example">
            <option value="Nama">Nama Lokasi</option>
            <option v-for="name in uniqueNames" :key="name" :value="name">{{ name }}</option>
          </select>
        </div>
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
        <tr v-for="location in filteredLocations" :key="location.id_lokasi">
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
import Papa from 'papaparse';
import 'jspdf-autotable';

export default {
  data() {
    return {
      locationsCsv: [],
      fileSelected: false,
      modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',
      searchText: '',
      selectedName: 'Nama',
    };
  },
  computed: {
    locations() {
      return this.$store.state.locations;
    },
    filteredLocations() {
      return this.locations.filter(locations =>
        this.searchLocations(locations, this.searchText.toLowerCase()) &&
        (this.selectedName === 'Nama' || locations.nama === this.selectedName)
      );
    },
    filteredLocationsCsv() {
      return this.locationsCsv.filter(locations =>
        this.searchLocations(locations, this.searchText.toLowerCase())
      );
    },
    uniqueNames() {
      const names = this.locations.map(locations => locations.nama).filter(Boolean);
      return [...new Set(names)];
    },
    uniqueAddress() {
      const address = this.locations.map(locations => locations.merk).filter(Boolean);
      return [...new Set(address)];
    },
  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'locations',
      dataKey: 'locations',
      mutation: 'setLocationsList',
    });
  },
  methods: {
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/locations/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
            window.location.reload();
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
    searchLocations(locations, searchText) {
      return Object.values(locations).some(
        value => value && value.toString().toLowerCase().includes(searchText)
      );
    },
    handleFileChange(event) {
      const fileInput = event.target;
      const file = fileInput.files[0];

      if (file && file.type === 'text/csv') {
        const reader = new FileReader();
        reader.onload = () => {
          const csvData = reader.result;
          const jsonData = this.convertCsvToJson(csvData);
          this.locationsCsv = jsonData
          // this.inventoriesCsv = jsonData.map(item => ({
          //   ...item,
          //   harga: Number(item.harga),
          //   nilai_residu: Number(item.nilai_residu),
          //   masa_manfaat: Number(item.masa_manfaat),
          //   depresiasi: Number(item.depresiasi),
          //   tahun_1: Number(item.tahun_1),
          //   tahun_2: Number(item.tahun_2),
          //   tahun_3: Number(item.tahun_3),
          //   tahun_4: Number(item.tahun_4),
          // }));
        };

        reader.readAsText(file);
        this.fileSelected = true;
      } else {
        this.fileSelected = false;
      }
    },
    convertCsvToJson(csvData) {
      const parsedData = Papa.parse(csvData, { header: true });
      return parsedData.data;
    },

    addDataToDatabase() {
      if (this.locationsCsv.length > 0) {
        const validLocations = this.locationsCsv.filter(location => {
          const values = Object.values(location);
          return values.every(value => value != null && value !== '');
        });

        if (validLocations.length > 0) {
          axios.post('http://localhost:8080/api/locations', validLocations)
            .then(response => {
              console.log('Data added successfully:', response.data);
              alert('Data added successfully.');
              this.fileSelected = false;
              window.location.reload();
            })
            .catch(error => {
              console.error('Error adding data:', error);
              alert('Failed to add data. Please try again later.');
            });
        } else {
          alert('No valid data to add. Please make sure all columns are filled.');
        }
      } else {
        alert('No data to add. Please select a valid CSV file.');
      }
    },

  },
};
</script>
  