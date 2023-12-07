<template>
  <h1>Page Data Karyawan</h1>
  <div class="d-flex flex-row mb-3">
    <div class="p-2">
      <button type="button" class="btn btn-secondary">Dowload as PDF</button>
    </div>
    <div class="p-2 ms-auto me-5">
      <button type="button" class="btn btn-success" @click="redirectToAddPage">Add Data</button>
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
      <tr v-for="employee in employees" :key="employee.nomor_induk">
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
                  <h1 class="modal-title fs-5 m-auto" id="staticBackdropLabel">Data {{ selectedItem.nama }}</h1>
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
                        <td class="text-start">{{ selectedItem.nomor_induk }}</td>
                        <td class="text-start">{{ selectedItem.nama }}</td>
                        <!-- <td class="text-start">{{ selectedItem.gender }}</td> -->
                        <td class="text-start">{{ getGenderText(selectedItem.gender) }}</td>

                        <td class="text-start">{{ selectedItem.email }}</td>
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
                        <td class="text-start">{{ selectedItem.telepon }}</td>
                        <td class="text-start">{{ selectedItem.jabatan }}</td>
                        <td class="text-start">{{ selectedItem.divisi }}</td>
                        <td class="text-start">{{ selectedItem.alamat }}</td>
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

export default {
  data() {
    return {
      employees: [],
      selectedItem: {},

    };
  },
  mounted() {
    this.fetchEmployees();
  },
  methods: {
    fetchEmployees() {
      axios.get('http://localhost:8080/api/employees')
        .then(response => {
          this.employees = response.data.employees;
        })
        .catch(error => {
          console.error('Error fetching employees:', error);
        });
    },
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/employees/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
            this.fetchEmployees(); // Refresh the items list
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
    showDetailModal(item) {
      this.selectedItem = item;
      // eslint-disable-next-line no-undef
      $('#staticBackdrop').modal('show');
    },
    getGenderText(gender) {
      return gender === 1 ? 'Male' : 'Female';
    },
  },
};
</script>


<style></style>