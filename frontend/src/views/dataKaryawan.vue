<template>
  <h1>Page Data Karyawan</h1>
  <div class="d-flex flex-row mb-3">
    <!-- <div class="p-2">
      <button type="button" class="btn btn-secondary">Dowload as PDF</button>
    </div> -->
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
                    <th>Nomor Induk</th>
                    <th>Nama</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Telepon</th>
                    <th>Jabatan</th>
                    <th>Divisi</th>
                    <th>Alamat</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="employees in filteredEmployeesCsv" :key="employees.kode_aset">
                    <td>{{ employees.nomor_induk }}</td>
                    <td>{{ employees.nama }}</td>
                    <td>{{ employees.gender }}</td>
                    <td>{{ employees.email }}</td>
                    <td>{{ employees.telepon }}</td>
                    <td>{{ employees.jabatan }}</td>
                    <td>{{ employees.divisi }}</td>
                    <td>{{ employees.alamat }}</td>
                    <td>{{ employees.vendor }}</td>
                    <td>
                      <button type="button" class="border border-dark btn btn-dark" data-bs-toggle="modal"
                        data-bs-target="#staticBackdrop" @click="showDetailModal(employees)">
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
    <div class="p-2 ms-auto">
      <div class="input-group flex-nowrap">
        <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
        <input v-model="searchText" @input="filterItems" type="text" class="form-control"
          placeholder="Search Employees..." aria-label="Username" aria-describedby="addon-wrapping" />
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
        <select v-model="selectedGender" class="form-select" aria-label="Default select example">
          <option value="Gender">Gender</option>
          <option v-for="gender in uniqueGenders" :key="gender" :value="gender">{{ getGenderText(gender) }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedPosition" class="form-select" aria-label="Default select example">
          <option value="Jabatan">Jabatan</option>
          <option v-for="position in uniquePositions" :key="position" :value="position">{{ position }}</option>
        </select>
      </div>

      <div class="col">
        <select v-model="selectedDivisi" class="form-select" aria-label="Default select example">
          <option value="Divisi">Divisi</option>
          <option v-for="divisi in uniqueDivisions" :key="divisi" :value="divisi">{{ divisi }}</option>
        </select>
      </div>
    </div>
  </div>

  <table class="table table-striped text-center ">
    <thead>
      <tr>
        <th class="text-uppercase"> Gambar </th>
        <th class="text-uppercase"> Nama </th>
        <th class="text-uppercase"> Email </th>
        <th class="text-uppercase"> Telepon </th>
        <th class="text-uppercase"> Jabatan </th>
        <th class="text-uppercase"> Divisi </th>
        <th class="text-uppercase"> action </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="employee in filteredEmployees" :key="employee.nomor_induk">
        <td>{{ employee.gambar }}</td>
        <td>{{ employee.nama }}</td>
        <td>{{ employee.email }}</td>
        <td>{{ employee.telepon }}</td>
        <td>{{ employee.jabatan }}</td>
        <td>{{ employee.divisi }}</td>
        <td>
          <button type="button" class="btn btn-warning" @click="redirectToEditPage(employee.nomor_induk)">Edit</button>
          <button type="button" class="btn btn-danger ms-2" @click="deleteItem(employee.nomor_induk)">Delete</button>
          <button type="button" class="btn btn-secondary ms-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
            @click="showDetailModal(employee)">
            Detail
          </button>

          <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-xl">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5 m-auto" id="staticBackdropLabel">Data {{ employees.nama }}</h1>
                </div>
                <div class="modal-body">
                  <table class="table table-striped table-hover">
                    <tbody>
                      <tr>
                        <td class="text-center align-middle" rowspan="6"> Gambar </td>
                        <th class="text-uppercase text-start" scope="row">Nomor Induk</th>
                        <th class="text-uppercase text-start" scope="row">Nama</th>
                        <th class="text-uppercase text-start">Gender</th>
                        <th class="text-uppercase text-start">Email</th>
                      </tr>

                      <tr>
                        <td class="text-start">{{ employees.nomor_induk }}</td>
                        <td class="text-start">{{ employees.nama }}</td>
                        <!-- <td class="text-start">{{ employees.gender }}</td> -->
                        <td class="text-start">{{ getGenderText(employees.gender) }}</td>

                        <td class="text-start">{{ employees.email }}</td>
                      </tr>

                      <tr>
                      </tr>

                      <tr>
                        <td colspan="8" class="invisible">.</td>
                      </tr>

                      <tr class="mt-2">

                        <th class="text-uppercase text-start">Telepon</th>
                        <th class="text-uppercase text-start">Jabatan</th>
                        <th class="text-uppercase text-start">Divisi</th>
                        <th class="text-uppercase text-start">Alamat</th>
                      </tr>

                      <tr>
                        <td class="text-start">{{ employees.telepon }}</td>
                        <td class="text-start">{{ employees.jabatan }}</td>
                        <td class="text-start">{{ employees.divisi }}</td>
                        <td class="text-start">{{ employees.alamat }}</td>
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
</template>

<script>
import axios from 'axios';
import router from '../router';
// import jsPDF from 'jspdf';
import Papa from 'papaparse';
import 'jspdf-autotable';

export default {
  data() {
    return {
      employeesCsv: [],
      selectedEmployees: {},
      fileSelected: false,
      modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',
      searchText: '',
      selectedGender: 'Gender',
      selectedPosition: 'Jabatan',
      selectedDivisi: 'Divisi',
    };
  },
  computed: {
    employees() {
      return this.$store.state.employees;
    },
    filteredEmployees() {
      return this.employees.filter(employees =>
        this.searchEmployees(employees, this.searchText.toLowerCase()) &&
        (this.selectedGender === 'Gender' || employees.gender === this.selectedGender) &&
        (this.selectedPosition === 'Jabatan' || employees.jabatan === this.selectedPosition) &&
        (this.selectedDivisi === 'Divisi' || employees.divisi === this.selectedDivisi)
      );
    },
    filteredEmployeesCsv() {
      return this.employeesCsv.filter(employees =>
        this.searchEmployees(employees, this.searchText.toLowerCase())
      );
    },
    uniquePositions() {
      const positions = this.employees.map(employees => employees.jabatan).filter(Boolean);
      return [...new Set(positions)];
    },
    uniqueGenders() {
      const genders = this.employees.map(employees => employees.gender).filter(Boolean);
      return [...new Set(genders)];
    },
    uniqueDivisions() {
      const divisions = this.employees.map(employees => employees.divisi).filter(Boolean);
      return [...new Set(divisions)];
    },
  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'employees',
      dataKey: 'employees',
      mutation: 'setEmployeesList',
    });
  },
  methods: {
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/employees/${itemId}`)
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
      window.location.href = 'http://localhost:8081/dataKaryawanADD';
    },
    redirectToEditPage(itemId) {
      router.push({ path: `/dataKaryawan/${itemId}` });
    },
    searchEmployees(employee, searchText) {
      return Object.values(employee).some(
        value => value && value.toString().toLowerCase().includes(searchText)
      );
    },
    showDetailModal(employeeId) {
      this.selectedEmployees = employeeId;
      this.modalBackgroundColor = 'rgba(0, 0, 0, 0.6)';
      const modalElement = document.getElementById('staticBackdrop');
      if (modalElement) {
        modalElement.modal('show');
      } else {
        console.error('Modal element not found.');
      }
    },
    getGenderText(gender) {
      return gender === 1 ? 'Male' : 'Female';
    },
    handleFileChange(event) {
      const fileInput = event.target;
      const file = fileInput.files[0];

      if (file && file.type === 'text/csv') {
        const reader = new FileReader();
        reader.onload = () => {
          const csvData = reader.result;
          const jsonData = this.convertCsvToJson(csvData);
          this.employeesCsv = jsonData.map(item => ({
            ...item,
            gender: Boolean(item.gender),
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
      const dataToSend = this.employeesCsv.length > 0 ? this.employeesCsv[0] : {};
      axios.post('http://localhost:8080/api/employees', dataToSend)
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