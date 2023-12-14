<template>
  <h1>Inventory List</h1>
  <div class="d-flex flex-row mb-3 ">
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
                    <th>Merk</th>
                    <th>Nama</th>
                    <th>Harga</th>
                    <th>Nilai Residu</th>
                    <th>Masa Manfaat</th>
                    <th>Depresiasi</th>
                    <th>Tahun 1</th>
                    <th>Tahun 2</th>
                    <th>Tahun 3</th>
                    <th>Tahun 4</th>
                    <th>Vendor</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="inventory in filteredInventoriesCsv" :key="inventory.kode_aset">
                    <td>{{ inventory.merk }}</td>
                    <td>{{ inventory.nama }}</td>
                    <td>{{ formatRupiah(inventory.harga) }}</td>
                    <td>{{ inventory.nilai_residu }}</td>
                    <td>{{ inventory.masa_manfaat }}</td>
                    <td>{{ inventory.depresiasi }}</td>
                    <td>{{ inventory.tahun_1 }}</td>
                    <td>{{ inventory.tahun_2 }}</td>
                    <td>{{ inventory.tahun_3 }}</td>
                    <td>{{ inventory.tahun_4 }}</td>
                    <td>{{ inventory.vendor }}</td>
                    <td>
                      <button type="button" class="border border-dark btn btn-dark" data-bs-toggle="modal"
                        data-bs-target="#staticBackdrop" @click="showDetailModal(inventory)">
                        Detail
                      </button>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <!-- Preview File di Csv -->
          </div>
        </div>
      </div>
    </div>
    <!-- <div class="p-2">
      <button type="button" class="btn btn-secondary" @click="generatePDFPreview">Download as PDF</button>
    </div> -->
    <div class="p-2 ms-auto">
      <div class="input-group flex-nowrap">
        <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
        <input v-model="searchText" @input="filterItems" type="text" class="form-control"
          placeholder="Search Inventories..." aria-label="Username" aria-describedby="addon-wrapping" />
      </div>
    </div>
    <div class="p-2 me-5">
      <button type="button" class="btn btn-success text-dark" @click="redirectToAddPage">Add Data</button>
    </div>
  </div>
  <div class="container text-center">
    <div class="row align-items-start">
      <div class="col">
        <p class="fw-bold fs-4">F I L T E R</p>
      </div>
      <div class="col">
        <select v-model="selectedName" class="form-select" aria-label="Default select example">
          <option value="Nama">Nama</option>
          <option v-for="name in uniqueNames" :key="name" :value="name">{{ name }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedCategory" class="form-select" aria-label="Default select example">
          <option value="Kategori">Kategori</option>
          <option v-for="category in uniqueCategories" :key="category" :value="category">{{ category }}</option>
        </select>
      </div>

      <div class="col">
        <select v-model="selectedBrand" class="form-select" aria-label="Default select example">
          <option value="Merk">Merk</option>
          <option v-for="brand in uniqueBrands" :key="brand" :value="brand">{{ brand }}</option>
        </select>
      </div>
    </div>
  </div>
  <div class="">
    <table id="example" class="table table-striped text-center">
      <thead>
        <tr>
          <th class="text-uppercase">Gambar</th>
          <th class="text-uppercase">Nama</th>
          <th class="text-uppercase">Merk</th>
          <th class="text-uppercase">Harga</th>
          <th class="text-uppercase">Deskripsi</th>
          <th class="text-uppercase">Kategori</th>
          <th class="text-uppercase">Action</th>
        </tr>
      </thead>
      <tbody>

        <tr v-for="inventory in filteredInventories" :key="inventory.kode_aset" class="text-break">
          <td>
            <img :src="inventory.img_url" alt="" srcset="" style="width: 100px; height: 100px; object-fit: cover;">
          </td>
          <td>{{ inventory.nama }}</td>
          <td>{{ inventory.merk }}</td>
          <td>{{ formatRupiah(inventory.harga) }}</td>
          <td>{{ inventory.deskripsi }}</td>
          <td>{{ inventory.Category ? inventory.Category.nama : '' }}</td>
          <td>
            <button type="button" class="btn btn-warning" @click="redirectToEditPage(inventory.kode_aset)">Edit</button>
            <button type="button" class="btn btn-danger ms-2"
              @click="deleteInventories(inventory.kode_aset)">Delete</button>
            <button type="button" class="btn btn-secondary ms-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
              @click="showDetailModal(inventory)">
              Detail
            </button>
            <!-- Modal -->
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
              aria-labelledby="staticBackdropLabel" aria-hidden="true" :style="{ backgroundColor: modalBackgroundColor }">
              <div class="modal-dialog modal-dialog-scrollable modal-xl">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5 m-auto" id="staticBackdropLabel">Data {{ inventory.nama }}</h1>
                  </div>
                  <div class="modal-body">
                    <table class="table table-striped table-hover">
                      <tbody>
                        <tr>
                          <td class="text-center align-middle" rowspan="6"> IMAGE </td>
                          <th class="text-uppercase text-start" scope="row">Kode Aset</th>
                          <th class="text-uppercase text-start" scope="row">Nama</th>
                          <th class="text-uppercase text-start">Merk</th>
                          <th class="text-uppercase text-start">Deskripsi</th>
                          <th class="text-uppercase text-start">Kategori</th>
                        </tr>
                        <tr>
                          <td class="text-start">{{ inventory.kode_aset }}</td>
                          <td class="text-start">{{ inventory.nama }}</td>
                          <td class="text-start">{{ inventory.merk }}</td>
                          <td class="text-start">{{ inventory.deskripsi }}</td>
                          <td class="text-start">{{ inventory.Category?.nama }}</td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                          <td colspan="8" class="invisible">.</td>
                        </tr>
                        <tr class="mt-2">
                          <th class="text-uppercase text-start">Tanggal</th>
                          <th class="text-uppercase text-start">Masa Manfaat</th>
                          <th class="text-uppercase text-start">Depresiasi</th>
                          <th class="text-uppercase text-start">Harga</th>
                          <th class="text-uppercase text-start">Nilai Residu</th>
                        </tr>
                        <tr>
                          <td class="text-start">{{ inventory.tanggal }}</td>
                          <td class="text-start">{{ inventory.masa_manfaat }}</td>
                          <td class="text-start">{{ inventory.depresiasi }}</td>
                          <td class="text-start">{{ inventory.harga }}</td>
                          <td class="text-start">{{ inventory.nilai_residu }}</td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                          <td class="text-center align-middle" rowspan="3"> STATUS / {{ inventory.status }}</td>
                          <td colspan="8" class="invisible">.</td>
                        </tr>
                        <tr>
                          <th class="text-uppercase text-start">Tahun 1</th>
                          <th class="text-uppercase text-start">Tahun 2</th>
                          <th class="text-uppercase text-start">Tahun 3</th>
                          <th class="text-uppercase text-start">Tahun 4</th>
                          <th class="text-uppercase text-start">Vendor</th>
                        </tr>
                        <tr>
                          <td class="text-start">{{ inventory.tahun_1 }}</td>
                          <td class="text-start">{{ inventory.tahun_2 }}</td>
                          <td class="text-start">{{ inventory.tahun_3 }}</td>
                          <td class="text-start">{{ inventory.tahun_4 }}</td>
                          <td class="text-start">{{ inventory.vendor }}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';
import router from '../router';
import jsPDF from 'jspdf';
import Papa from 'papaparse';
import 'jspdf-autotable';

export default {
  data() {
    return {
      inventoriesCsv: [],
      selectedInventories: {},
      fileSelected: false,
      modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',
      searchText: '',
      selectedName: 'Nama',
      selectedCategory: 'Kategori',
      selectedBrand: 'Merk',
    };
  },
  computed: {
    inventories() {
      return this.$store.state.inventories;
    },
    filteredInventories() {
      return this.inventories.filter(inventory =>
        this.searchInventories(inventory, this.searchText.toLowerCase()) &&
        (this.selectedName === 'Nama' || inventory.nama === this.selectedName) &&
        (this.selectedCategory === 'Kategori' || inventory.Category?.nama === this.selectedCategory) &&
        (this.selectedBrand === 'Merk' || inventory.merk === this.selectedBrand)
      );
    },
    filteredInventoriesCsv() {
      return this.inventoriesCsv.filter(inventory =>
        this.searchInventories(inventory, this.searchText.toLowerCase())
      );
    },
    uniqueCategories() {
      const categories = this.inventories.map(inventory => inventory.Category?.nama).filter(Boolean);
      return [...new Set(categories)];
    },
    uniqueNames() {
      const names = this.inventories.map(inventory => inventory.nama).filter(Boolean);
      return [...new Set(names)];
    },
    uniqueBrands() {
      const brands = this.inventories.map(inventory => inventory.merk).filter(Boolean);
      return [...new Set(brands)];
    },
  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'inventories',
      dataKey: 'inventory',
      mutation: 'setInventoriesList',
    });
  },
  methods: {
    searchInventories(inventory, searchText) {
      return Object.values(inventory).some(
        value => value && value.toString().toLowerCase().includes(searchText)
      );
    },
    deleteInventories(inventoryId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/inventories/${inventoryId}`)
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
      window.location.href = 'http://localhost:8081/InventoryADD';
    },
    redirectToEditPage(inventoryId) {
      router.push({ path: `/inventory/${inventoryId}` });
    },
    formatRupiah(angka) {
      const stringValue = angka?.toString() || '0';
      var reverse = stringValue.split('').reverse().join(''),
        ribuan = reverse.match(/\d{1,3}/g);
      ribuan = ribuan.join('.').split('').reverse().join('');
      return 'Rp. ' + ribuan;
    },
    showDetailModal(inventoryId) {
      this.selectedInventories = inventoryId;
      this.modalBackgroundColor = 'rgba(0, 0, 0, 0.6)';
      const modalElement = document.getElementById('staticBackdrop');
      if (modalElement) {
        modalElement.modal('show');
      } else {
        console.error('Modal element not found.');
      }
    },
    generatePDFPreview() {
      const doc = new jsPDF();
      const currentDate = new Date();
      const formattedDate = `${currentDate.getDate()}/${currentDate.getMonth() + 1}/${currentDate.getFullYear()}`;
      const formattedTime = `${currentDate.getHours()}:${currentDate.getMinutes()}:${currentDate.getSeconds()}`;
      doc.setFont('times');
      doc.setFontSize(10);
      doc.text(`${formattedDate} ${formattedTime}`, 170, 9);
      doc.setFont('helvetica');
      doc.setFontSize(18);
      doc.text('INVENTORY LIST', 80, 15);
      const headers = ['Nama', 'Merk', 'Harga', 'Kategori', 'Depresiasi', 'Vendor', 'Deskripsi'];
      const data = this.filteredInventories.map(inventory => [
        inventory.nama,
        inventory.merk,
        this.formatRupiah(inventory.harga),
        inventory.Category.nama,
        inventory.depresiasi,
        inventory.vendor,
        inventory.deskripsi,
      ]);
      const autoTableConfig = {
        startY: 20,
        head: [headers],
        body: data,
        theme: 'grid',
      };
      doc.autoTable(autoTableConfig);
      doc.output('dataurlnewwindow');
    },
    handleFileChange(event) {
      const fileInput = event.target;
      const file = fileInput.files[0];

      if (file && file.type === 'text/csv') {
        const reader = new FileReader();
        reader.onload = () => {
          const csvData = reader.result;
          const jsonData = this.convertCsvToJson(csvData);
          this.inventoriesCsv = jsonData.map(item => ({
            ...item,
            harga: Number(item.harga),
            nilai_residu: Number(item.nilai_residu),
            masa_manfaat: Number(item.masa_manfaat),
            depresiasi: Number(item.depresiasi),
            tahun_1: Number(item.tahun_1),
            tahun_2: Number(item.tahun_2),
            tahun_3: Number(item.tahun_3),
            tahun_4: Number(item.tahun_4),
          }));
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
      const dataToSend = this.inventoriesCsv.length > 0 ? this.inventoriesCsv[0] : {};
      axios.post('http://localhost:8080/api/inventories', dataToSend)
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
    },
  },
};
</script>

<style></style>