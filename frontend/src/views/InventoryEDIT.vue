<template>
  <div>
    <h1>Edit Inventory Item</h1>
    <div class="container">
      <form @submit.prevent="updateInventory">

        <div class="row row-cols-2 row-cols-lg-4 g-lg-3">

          <div class="col form-group">
            <label for="kodeAset">Kode Aset</label>
            <input v-model="inventoryItem.kode_aset" type="text" class="form-control" id="kodeAset" disabled>
          </div>

          <div class="col form-group">
            <label for="merk">merk</label>
            <input v-model="inventoryItem.merk" type="text" class="form-control" id="merk" required>
          </div>

          <div class="col form-group">
            <label for="name">Name</label>
            <input v-model="inventoryItem.nama" type="text" class="form-control" id="name" required>
          </div>

          <div class="col form-group">
            <label for="tanggal" class="form-label">Tanggal</label>
            <input v-model="inventoryItem.tanggal" type="text" class="form-control" id="tanggal">
          </div>

          <div class="col form-group">
            <label for="harga" class="form-label">Harga</label>
            <input v-model="inventoryItem.harga" type="number" class="form-control" id="harga">
          </div>

          <div class="col form-group">
            <label for="nilai_residu" class="form-label">Nilai Residu</label>
            <input v-model="inventoryItem.nilai_residu" type="number" class="form-control" id="nilai_residu">
          </div>

          <div class="col form-group">
            <label for="masa_manfaat" class="form-label">Masa Manfaat</label>
            <input v-model="inventoryItem.masa_manfaat" type="number" class="form-control" id="masa_manfaat">
          </div>

          <div class="col form-group">
            <label for="depresiasi" class="form-label">Depresiasi</label>
            <input v-model="inventoryItem.depresiasi" type="number" class="form-control" id="depresiasi" readonly>
          </div>

          <div class="col form-group">
            <label for="deskripsi" class="form-label">Deskripsi</label>
            <input v-model="inventoryItem.deskripsi" type="text" class="form-control" id="deskripsi" required>
          </div>

          <div class="col form-group">
            <label for="status" class="form-label">Status</label>
            <input v-model="inventoryItem.status" type="text" class="form-control" id="status" required>
          </div>

          <div class="col form-group">
            <label for="id_kategori" class="form-label">Kategori</label>
            <select v-model="inventoryItem.id_kategori" class="form-select" id="id_kategori" required>
              <option v-for="category in categories" :value="category.id_kategori" :key="category.id_kategori">
                {{ category.nama }}
              </option>
            </select>
          </div>

          <!-- <div class="col form-group">
            <label for="id_ruangan" class="form-label">Ruangan</label>
            <select v-model="inventoryItem.id_ruangan" class="form-select" id="id_ruangan" required>
              <option v-for="room in rooms" :value="room.id_ruangan" :key="room.id_ruangan">
                {{ room.nama }}
              </option>
            </select>
          </div> -->



          <!-- <div class="col form-group">
            <label for="nomor_induk" class="form-label">Nomor Induk Karyawan</label>
            <select v-model="inventoryItem.nomor_induk" class="form-select" id="nomor_induk" required>
              <option v-for="employee in employees" :value="employee.nomor_induk" :key="employee.nomor_induk">
                {{ employee.nomor_induk }}
              </option>
            </select>
          </div> -->

          <div class="col form-group">
            <label for="tahun_1" class="form-label">Tahun 1</label>
            <input v-model="inventoryItem.tahun_1" type="number" class="form-control" id="tahun_1">
          </div>

          <div class="col form-group">
            <label for="tahun_2" class="form-label">Tahun 2</label>
            <input v-model="inventoryItem.tahun_2" type="number" class="form-control" id="tahun_2">
          </div>

          <div class="col form-group">
            <label for="tahun_3" class="form-label">Tahun 3</label>
            <input v-model="inventoryItem.tahun_3" type="number" class="form-control" id="tahun_3">
          </div>

          <div class="col form-group">
            <label for="tahun_4" class="form-label">Tahun 4</label>
            <input v-model="inventoryItem.tahun_4" type="number" class="form-control" id="tahun_4">
          </div>

          <div class="col form-group">
            <label for="img_url" class="form-label">Img URL</label>
            <input v-model="inventoryItem.img_url" type="text" class="form-control" id="img_url">
          </div>

          <div class="col form-group">
            <label for="vendor" class="form-label">Vendor</label>
            <input v-model="inventoryItem.vendor" type="text" class="form-control" id="vendor">
          </div>

          <div class="col form-group">
            <button type="submit" class="btn btn-primary">Update Data</button>

          </div>

        </div>

        <!-- Brand -->
        <!-- <div class="form-group">
          <label for="brand">Brand</label>
          <input v-model="inventoryItem.merk" type="text" class="form-control" id="brand" required>
        </div> -->

        <!-- Date -->
        <!-- <div class="form-group">
          <label for="tanggal">Tanggal</label>
          <input v-model="inventoryItem.tanggal" type="date" class="form-control" id="tanggal">
        </div> -->

        <!-- Price -->
        <!-- <div class="form-group">
          <label for="harga">Harga</label>
          <input v-model="inventoryItem.harga" type="number" class="form-control" id="harga">
        </div> -->

        <!-- Nilai Residu -->
        <!-- <div class="form-group">
          <label for="nilaiResidu">Nilai Residu</label>
          <input v-model="inventoryItem.nilai_residu" type="number" class="form-control" id="nilai_residu">
        </div> -->

        <!-- ... Add other fields as needed ... -->

        <!-- Submit Button -->
      </form>
    </div>
  </div>
</template>
  
<script>
import axios from 'axios';

export default {
  data() {
    return {
      inventoryItem: {
        kode_aset: '',
        merk: '',
        nama: '',
        tanggal: '',
        harga: '',
        nilai_residu: '',
        masa_manfaat: '',
        depresiasi: '',
        deskripsi: '',
        status: '',
        id_kategori: '',
        tahun_1: '',
        tahun_2: '',
        tahun_3: '',
        tahun_4: '',
        img_url: '',
        vendor: '',
      },
      rooms: [],
      categories: [],
      employees: [],
    };
  },
  created() {
    this.fetchInventoryItem();
    this.fetchCategories();
    this.fetchEmployees();
    this.fetchRooms();

  },
  methods: {
    fetchInventoryItem() {
      const itemId = this.$route.params.id;
      axios.get(`http://localhost:8080/api/inventories/${itemId}`)
        .then(response => {
          this.inventoryItem = response.data.inventory;
        })
        .catch(error => {
          console.error('Error fetching inventory item:', error);
        });
    },
    updateInventory() {
      axios.put(`http://localhost:8080/api/inventories/${this.inventoryItem.kode_aset}`, this.inventoryItem)
        .then(() => {
          // Handle successful update
          alert('Inventory item updated successfully');
        })
        .catch(error => {
          console.error('Error updating inventory item:', error);
        });
    },
    fetchCategories() {
      axios.get('http://localhost:8080/api/categories')
        .then(response => {
          this.categories = response.data.categories;
        })
        .catch(error => {
          console.error('Error fetching categories:', error);
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
  