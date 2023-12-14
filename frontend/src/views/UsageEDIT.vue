<template>
  <div>
    <h1>Edit Usage Item</h1>
    <div class="container">
      <form @submit.prevent="updateUsages">
        <div class="row row-cols-2 row-cols-lg-4 g-lg-3">
          <div class="col form-group">
            <label for="id_pemakaian">Id Pemakaian</label>
            <input v-model="usages.id_pemakaian" type="text" class="form-control" id="id_pemakaian" disabled>
          </div>

          <div class="col">
            <div class=""><label for="kode_aset" class="form-label">Kode Aset</label>
              <select v-model="usages.kode_aset" class="form-select" id="kode_aset">
                <option v-for="inventorie in inventories" :value="inventorie.kode_aset" :key="inventorie.kode_aset">
                  {{ inventorie.nama }}
                </option>
              </select>
            </div>
          </div>

          <div class="col">
            <div class=""><label for="nomor_induk" class="form-label">Nomor Induk</label>
              <select v-model="usages.nomor_induk" class="form-select" id="nomor_induk">
                <option v-for="employee in employees" :value="employee.nomor_induk" :key="employee.nomor_induk">
                  {{ employee.nama }}
                </option>
              </select>
            </div>
          </div>

          <div class="col">
            <div class=""><label for="id_ruangan" class="form-label">Id Ruangan</label>
              <select v-model="usages.id_ruangan" class="form-select" id="id_ruangan">
                <option v-for="room in rooms" :value="room.id_ruangan" :key="room.id_ruangan">
                  {{ room.nama }}
                </option>
              </select>
            </div>
          </div>

          <div class="col">
            <div class="">
              <label for="status" class="form-label">Status</label>
              <select v-model="usages.status" class="form-select" id="status">
                <option value="baik">Baik</option>
                <option value="rusak">Rusak</option>
              </select>
            </div>
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

export default {
  data() {
    return {
      usages: {
        id_pemakaian: '',
        kode_aset: '',
        nomor_induk: '',
        id_ruangan: '',
        status: '',

      },
      rooms: [],
      inventories: [],
      employees: [],
    };
  },
  created() {
    this.fetchUsages();
    this.fetchInventories();
    this.fetchEmployees();
    this.fetchRooms();
  },
  methods: {
    updateUsages() {
      axios.put(`http://localhost:8080/api/usages/${this.usages.id_pemakaian}`, this.usages)
        .then(() => {
          alert('Usages item updated successfully');
        })
        .catch(error => {
          console.error('Error updating usages item:', error);
        });
    },
    fetchUsages() {
      const itemId = this.$route.params.id;
      axios.get(`http://localhost:8080/api/usages/${itemId}`)
        .then(response => {
          this.usages = response.data.usage;
        })
        .catch(error => {
          console.error('Error fetching usages:', error);
        });
    },
    fetchInventories() {
      axios.get('http://localhost:8080/api/inventories')
        .then(response => {
          this.inventories = response.data.inventory;
        })
        .catch(error => {
          console.error('Error fetching inventories:', error);
        });
    },
    fetchEmployees() {
      axios.get('http://localhost:8080/api/employees')
        .then(response => {
          this.employees = response.data.employees;
        })
        .catch(error => {
          console.error('Error fetching employees:', error);
        });
    },
    fetchRooms() {
      axios.get('http://localhost:8080/api/rooms')
        .then(response => {
          this.rooms = response.data.rooms;
        })
        .catch(error => {
          console.error('Error fetching rooms:', error);
        });
    },
  },
};
</script>
    
<style></style>
