<template>
  <div>
    <h1>Usage List</h1>
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
                      <th>Nama Aset</th>
                      <th>Nama Karyawan</th>
                      <th>Nama Ruangan</th>
                      <th>Status</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="usage in filteredUsagesCsv" :key="usage.id_pemakaian">
                      <td>{{ usage.id_pemakaian }}</td>
                      <td>{{ usage.kode_aset }}</td>
                      <td>{{ usage.nomor_induk }}</td>
                      <td>{{ usage.id_ruangan }}</td>
                      <td>{{ usage.status }}</td>
                      <td>
                        <button type="button" class="border border-dark btn btn-dark" data-bs-toggle="modal"
                          data-bs-target="#staticBackdrop" @click="showDetailModal(usage)">
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
        <button type="button" class="btn btn-secondary">Dowload as PDF</button>
      </div> -->
      <div class="p-2 ms-auto">
        <div class="input-group flex-nowrap">
          <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
          <input v-model="searchText" @input="filterItems" type="text" class="form-control"
            placeholder="Search Usages..." aria-label="Username" aria-describedby="addon-wrapping" />
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
            <select v-model="selectedAset" class="form-select" aria-label="Default select example">
              <option value="Aset">Aset</option>
              <option v-for="kode_aset in uniqueAsets" :key="kode_aset" :value="kode_aset">{{ kode_aset }}</option>
            </select>
        </div>
        <div class="col">
          <select v-model="selectedEmployee" class="form-select" aria-label="Default select example">
            <option value="Karyawan">Karyawan</option>
            <option v-for="employee in uniqueEmployees" :key="employee" :value="employee"> {{ employee }} </option>
          </select>
      </div>
  
      <div class="col">
        <select v-model="selectedRoom" class="form-select" aria-label="Default select example">
          <option value="Ruangan">Ruangan</option>
          <option v-for="room in uniqueRooms" :key="room" :value="room">{{ room }}</option>
        </select>
      </div>

      <div class="col">
        <select v-model="selectedStatus" class="form-select" aria-label="Default select example">
          <option value="Status">Status</option>
          <option v-for="status in uniqueStatus" :key="status" :value="status">{{ status }}</option>
        </select>
      </div>
      </div>
    </div>

    <table class="table table-striped text-center ">
      <thead>
        <tr>
          <!-- <th class="text-uppercase"> Id Pemakaian </th> -->
          <th class="text-uppercase"> Nama Aset </th>
          <th class="text-uppercase"> Nama Karyawan</th>
          <th class="text-uppercase"> Nama Ruangan </th>
          <th class="text-uppercase"> Status </th>
          <th class="text-uppercase"> Action </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="usage in filteredUsages" :key="usage.id_pemakaian">
          <!-- <td>{{ usage.id_pemakaian }}</td> -->
        <td>{{ usage.Inventory.nama }}</td>
        <td>{{ usage.Employee.nama }}</td>
        <td>{{ usage.Room.nama }} - {{ usage.Room.Location.nama }}</td>
        <td>{{ usage.status }}</td>
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
import jsPDF from 'jspdf';
import Papa from 'papaparse';
import 'jspdf-autotable';

export default {
  data() {
    return {
      usagesCsv: [],
      selectedUsages: {},
      fileSelected: false,
      modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',
      searchText: '',
      selectedAset: 'Aset',
      selectedEmployee: 'Karyawan',
      selectedRoom: 'Ruangan',
      selectedStatus: 'Status',
    };
  },
  computed: {
    usages() {
      return this.$store.state.usages;
    },
    filteredUsages() {
      return this.usages.filter(usages =>
        this.searchUsages(usages, this.searchText.toLowerCase()) &&
        (this.selectedAset === 'Aset' || usages.Inventory?.nama === this.selectedAset) &&
        (this.selectedEmployee === 'Karyawan' || usages.Employee?.nama === this.selectedEmployee) &&
        (this.selectedRoom === 'Ruangan' || usages.Room?.nama === this.selectedRoom) &&
        (this.selectedStatus === 'Status' || usages.status === this.selectedStatus)
      );
    },
    filteredUsagesCsv() {
      return this.usagesCsv.filter(usages =>
        this.searchUsages(usages, this.searchText.toLowerCase())
      );
    },
    uniqueAsets() {
      const asets = this.usages.map(usages => usages.Inventory?.nama).filter(Boolean);
      return [...new Set(asets)];
    },
    uniqueEmployees() {
      const employees = this.usages.map(usages => usages.Employee?.nama).filter(Boolean);
      return [...new Set(employees)];
    },
    uniqueRooms() {
      const rooms = this.usages.map(usages => usages.Room?.nama).filter(Boolean);
      return [...new Set(rooms)];
    },
    uniqueStatus() {
      const status = this.usages.map(usages => usages.status).filter(Boolean);
      return [...new Set(status)];
    },
  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'usages',
      dataKey: 'usages',
      mutation: 'setUsagesList',
    });
  },
  methods: {
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
    searchUsages(usages, searchText) {
      return Object.values(usages).some(
        value => value && value.toString().toLowerCase().includes(searchText)
      );
    },
    showDetailModal(usagesId) {
      this.selectedUsages = usagesId;
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
      doc.text('USAGES LIST', 80, 15);
      const headers = ['Aset', 'Karyawan', 'Ruangan', 'Status'];
      const data = this.filteredUsages.map(usages => [
        usages.Inventory?.nama,
        usages.Employee?.nama,
        usages.Room?.nama,
        usages.status,
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
          // this.usagesCsv = jsonData.map(item => ({
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
          this.usagesCsv = jsonData
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
      const dataToSend = this.usagesCsv.length > 0 ? this.usagesCsv[0] : {};
      axios.post('http://localhost:8080/api/usages', dataToSend)
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
