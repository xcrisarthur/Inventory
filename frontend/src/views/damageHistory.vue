<template>
  <div class="d-flex flex-row mb-3 ">
    <div class="col col-8 me-start">
      <h1>Page Repair & Damage History</h1>
    </div>
  </div>
  <div class="d-flex flex-row mb-3 ">
    <div class="">
      <h3>Damage History</h3>
    </div>
    <div class=" ms-auto me-5">
      <div class="input-group flex-nowrap">
        <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
        <input v-model="searchTextDamage" @input="filterItems" type="text" class="form-control"
          placeholder="Search Damages..." aria-label="Username" aria-describedby="addon-wrapping" />
      </div>
    </div>
    <div class="me-5">
      <button type="button" class="btn btn-success text-dark" @click="redirectToDamageAddPage">Add Data</button>
    </div>
  </div>

  <div class="container text-center">
    <div class="row align-items-start">
      <div class="col">
        <p class="fw-bold fs-4">F I L T E R</p>
      </div>
      <div class="col">
        <select v-model="selectedNameDamage" class="form-select" aria-label="Default select example">
          <option value="Nama">Nama</option>
          <option v-for="name in uniqueDamageNames" :key="name" :value="name">{{ name }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedCategoryDamage" class="form-select" aria-label="Default select example">
          <option value="Kategori">Kategori</option>
          <option v-for="categorie in uniqueDamageCategories" :key="categorie" :value="categorie">{{ categorie }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedRoomDamage" class="form-select" aria-label="Default select example">
          <option value="Ruangan">Ruangan</option>
          <option v-for="room in uniqueDamageRooms" :key="room" :value="room">{{ room }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedEmployeeDamage" class="form-select" aria-label="Default select example">
          <option value="Karyawan">Karyawan</option>
          <option v-for="employee in uniqueDamageEmployees" :key="employee" :value="employee">{{ employee }}</option>
        </select>
      </div>
    </div>
  </div>
  <table class="table table-striped text-center ">
    <thead>
      <tr>
        <th class="text-uppercase"> Nama </th>
        <th class="text-uppercase"> Tanggal <br> Kerusakan </th>
        <th class="text-uppercase"> Status </th>
        <th class="text-uppercase"> Room & <br> Location </th>
        <th class="text-uppercase"> Nama <br> Karyawan </th>
        <th class="text-uppercase"> Action </th>

      </tr>
    </thead>
    <tbody>
      <tr v-for="DamageHistory in filteredDamageHistorys" :key="DamageHistory.id">
        <td>{{ DamageHistory.Usage.Inventory.nama }}</td>
        <td>{{ DamageHistory.tanggal_kerusakan }}</td>
        <td>{{ DamageHistory.Usage.status }}</td>
        <td>{{ DamageHistory.Usage.Room.nama }} ( {{ DamageHistory.Usage.Room.Location.nama }} ) </td>
        <td>{{ DamageHistory.Usage.Employee.nama }}</td>
        <td>
          <button type="button" class="btn btn-warning" @click="redirectToDamageEditPage(DamageHistory.id)">Edit</button>
          <button type="button" class="btn btn-danger ms-2" @click="deleteDamageHistory(DamageHistory.id)">Delete</button>
          <button type="button" class="btn btn-secondary ms-2" data-bs-toggle="modal" data-bs-target="#damageModal"
            @click="showDetailModal(DamageHistory)">
            Detail
          </button>
          <!-- Modal -->
          <div class="modal fade" id="damageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="damageModalLabel" aria-hidden="true" :style="{ backgroundColor: modalBackgroundColor }">
            <div class="modal-dialog modal-dialog-scrollable modal-xl">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5 m-auto" id="damageModalLabel">Data {{ DamageHistory.Usage.Inventory.nama }}
                  </h1>
                </div>
                <div class="modal-body">
                  <table class="table table-striped table-hover">
                    <tbody>
                      <tr>
                        <td class="text-center align-middle" rowspan="6"> IMAGE </td>
                        <th class="text-uppercase text-start" scope="row">nama Ruangan</th>
                        <th class="text-uppercase text-start" scope="row">Lokasi & Alamat</th>
                        <th class="text-uppercase text-start">Nama Karyawan</th>
                        <th class="text-uppercase text-start">nama Item</th>
                        <th class="text-uppercase text-start">Kategori item</th>
                      </tr>
                      <tr>
                        <td class="text-start">{{ DamageHistory.Usage.Room.nama }}</td>
                        <td class="text-start">{{ DamageHistory.Usage.Room.Location.nama }} - {{
                          DamageHistory.Usage.Room.Location.alamat }}</td>
                        <td class="text-start">{{ DamageHistory.Usage.Employee.nama }}</td>
                        <td class="text-start">{{ DamageHistory.Usage.Inventory.nama }}</td>
                        <td class="text-start">{{ DamageHistory.Usage.Inventory.Category?.nama }}</td>
                      </tr>
                      <tr>
                      </tr>
                      <tr>
                        <td colspan="8" class="invisible">.</td>
                      </tr>
                      <tr class="mt-2">
                        <th class="text-uppercase text-start">Tanggal Kerusakan</th>
                        <!-- <th class="text-uppercase text-start">Masa Manfaat</th>
                        <th class="text-uppercase text-start">Depresiasi</th>
                        <th class="text-uppercase text-start">Harga</th>
                        <th class="text-uppercase text-start">Nilai Residu</th> -->
                      </tr>
                      <tr>
                        <td class="text-start">{{ DamageHistory.tanggal_kerusakan }}</td>
                        <!-- <td class="text-start">{{ inventory.masa_manfaat }}</td>
                        <td class="text-start">{{ inventory.depresiasi }}</td>
                        <td class="text-start">{{ inventory.harga }}</td>
                        <td class="text-start">{{ inventory.nilai_residu }}</td> -->
                      </tr>
                      <tr>
                      </tr>
                      <tr>
                        <td class="text-center align-middle" rowspan="3"> STATUS / {{ DamageHistory.Usage.status }}</td>
                        <td colspan="8" class="invisible">.</td>
                      </tr>
                      <tr>
                        <!-- <th class="text-uppercase text-start">Tahun 1</th>
                        <th class="text-uppercase text-start">Tahun 2</th>
                        <th class="text-uppercase text-start">Tahun 3</th>
                        <th class="text-uppercase text-start">Tahun 4</th>
                        <th class="text-uppercase text-start">Vendor</th> -->
                      </tr>
                      <tr>
                        <!-- <td class="text-start">{{ inventory.tahun_1 }}</td>
                        <td class="text-start">{{ inventory.tahun_2 }}</td>
                        <td class="text-start">{{ inventory.tahun_3 }}</td>
                        <td class="text-start">{{ inventory.tahun_4 }}</td>
                        <td class="text-start">{{ inventory.vendor }}</td> -->
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

  <div class="d-flex flex-row mb-3 ">
    <div class="">
      <h3>Repair History</h3>
    </div>
    <div class=" ms-auto me-5">
      <div class="input-group flex-nowrap">
        <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
        <input v-model="searchTextRepair" @input="filterItems" type="text" class="form-control"
          placeholder="Search Repair..." aria-label="Username" aria-describedby="addon-wrapping" />
      </div>
    </div>
    <div class="me-5">
      <button type="button" class="btn btn-success text-dark" @click="redirectToRepairAddPage">Add Data</button>
    </div>
  </div>

  <div class="container text-center">
    <div class="row align-items-start">
      <div class="col">
        <p class="fw-bold fs-4">F I L T E R</p>
      </div>
      <div class="col">
        <select v-model="selectedNameRepair" class="form-select" aria-label="Default select example">
          <option value="Nama">Nama</option>
          <option v-for="name in uniqueRepairNames" :key="name" :value="name">{{ name }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedCategoryRepair" class="form-select" aria-label="Default select example">
          <option value="Kategori">Kategori</option>
          <option v-for="categorie in uniqueRepairCategories" :key="categorie" :value="categorie">{{ categorie }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedRoomRepair" class="form-select" aria-label="Default select example">
          <option value="Ruangan">Ruangan</option>
          <option v-for="room in uniqueRepairRooms" :key="room" :value="room">{{ room }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedEmployeeRepair" class="form-select" aria-label="Default select example">
          <option value="Karyawan">Karyawan</option>
          <option v-for="employee in uniqueRepairEmployees" :key="employee" :value="employee">{{ employee }}</option>
        </select>
      </div>
    </div>
  </div>


  <table class="table table-striped text-center">
    <thead>
      <tr>
        <th class="text-uppercase"> Nama </th>
        <th class="text-uppercase"> Tanggal <br> Selesai Perbaikan </th>

        <!-- <th class="text-uppercase"> Tanggal <br> Perbaikan </th> -->
        <th class="text-uppercase"> Biaya </th>
        <th class="text-uppercase"> Deskripsi </th>
        <!-- <th class="text-uppercase"> Tanggal <br> Kerusakan </th> -->
        <!-- <th class="text-uppercase"> Id <br> Pemakaian </th> -->
        <th class="text-uppercase"> Tempat <br> Perbaikan </th>
        <th class="text-uppercase"> Action </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="RepairHistory in filteredRepairHistorys" :key="RepairHistory.id_perbaikan">
        <!-- <td>{{ RepairHistory.tanggal_perbaikan }}</td> -->
        <td>{{ RepairHistory.ReportHistoryKerusakan.Usage.Inventory.nama }}</td>
        <td>{{ RepairHistory.tanggal_selesai_perbaikan }}</td>

        <td>{{ RepairHistory.biaya }}</td>
        <td>{{ RepairHistory.deskripsi }}</td>
        <!-- <td>{{ RepairHistory.tanggal_kerusakan }}</td> -->
        <!-- <td>{{ RepairHistory.id_pemakaian }}</td> -->
        <td>{{ RepairHistory.tempat_perbaikan }}</td>
        <td>
          <button type="button" class="btn btn-warning" @click="redirectToRepairEditPage(RepairHistory.id_perbaikan)">Edit</button>
          <button type="button" class="btn btn-danger ms-2" @click="deleteRepairHistory(RepairHistory.id_perbaikan)">Delete</button>
          <button type="button" class="btn btn-secondary ms-2" data-bs-toggle="modal" data-bs-target="#repairModal"
            @click="showDetailModal(RepairHistory)">
            Detail
          </button>
          <!-- Modal -->
          <div class="modal fade" id="repairModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="repairModalLabel" aria-hidden="true" :style="{ backgroundColor: modalBackgroundColor }">
            <div class="modal-dialog modal-dialog-scrollable modal-xl">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5 m-auto" id="repairModalLabel">Data {{ RepairHistory.ReportHistoryKerusakan.id }}
                  </h1>
                </div>
                <div class="modal-body">
                  <table class="table table-striped table-hover">
                    <tbody>
                      <tr>
                        <td class="text-center align-middle" rowspan="6"> IMAGE </td>
                        <th class="text-uppercase text-start" scope="row">nama Ruangan</th>
                        <th class="text-uppercase text-start" scope="row">Lokasi & Alamat</th>
                        <th class="text-uppercase text-start">Nama Karyawan</th>
                        <th class="text-uppercase text-start">nama Item</th>
                        <th class="text-uppercase text-start">Kategori item</th>
                      </tr>
                      <tr>
                        <td class="text-start">{{ RepairHistory.ReportHistoryKerusakan.Usage.Room.nama }}</td>
                        <td class="text-start">{{ RepairHistory.ReportHistoryKerusakan.Usage.Room.Location.nama }} - {{
                          RepairHistory.ReportHistoryKerusakan.Usage.Room.Location.alamat }}</td>
                        <td class="text-start">{{ RepairHistory.ReportHistoryKerusakan.Usage.Employee.nama }}</td>
                        <td class="text-start">{{ RepairHistory.ReportHistoryKerusakan.Usage.Inventory.nama }}</td>
                        <td class="text-start">{{ RepairHistory.ReportHistoryKerusakan.Usage.Inventory.Category?.nama }}</td>
                      </tr>
                      <tr>
                      </tr>
                      <tr>
                        <td colspan="8" class="invisible">.</td>
                      </tr>
                      <tr class="mt-2">
                        <th class="text-uppercase text-start">Tanggal Kerusakan</th>
                        <th class="text-uppercase text-start">tanggal_perbaikan</th>
                        <th class="text-uppercase text-start">biaya</th>
                        <th class="text-uppercase text-start">deskripsi</th>
                        <th class="text-uppercase text-start">tanggal_selesai_perbaikan</th>
                      </tr>
                      <tr>
                        <td class="text-start">{{ RepairHistory.tanggal_kerusakan }}</td>
                        <td class="text-start">{{ RepairHistory.tanggal_perbaikan }}</td>
                        <td class="text-start">{{ RepairHistory.biaya }}</td>
                        <td class="text-start">{{ RepairHistory.deskripsi }}</td>
                        <td class="text-start">{{ RepairHistory.tanggal_selesai_perbaikan }}</td>
                      </tr>
                      <tr>
                      </tr>
                      <tr>
                        <td class="text-center align-middle" rowspan="3"> STATUS / {{ RepairHistory.ReportHistoryKerusakan.Usage.status }}</td>
                        <td colspan="8" class="invisible">.</td>
                      </tr>
                      <tr>
                        <!-- <th class="text-uppercase text-start">Tahun 1</th>
                        <th class="text-uppercase text-start">Tahun 2</th>
                        <th class="text-uppercase text-start">Tahun 3</th>
                        <th class="text-uppercase text-start">Tahun 4</th>
                        <th class="text-uppercase text-start">Vendor</th> -->
                      </tr>
                      <tr>
                        <!-- <td class="text-start">{{ inventory.tahun_1 }}</td>
                        <td class="text-start">{{ inventory.tahun_2 }}</td>
                        <td class="text-start">{{ inventory.tahun_3 }}</td>
                        <td class="text-start">{{ inventory.tahun_4 }}</td>
                        <td class="text-start">{{ inventory.vendor }}</td> -->
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
import jsPDF from 'jspdf';
import Papa from 'papaparse';
import 'jspdf-autotable';

export default {
  data() {
    return {
      fileSelected: false,
      modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',

      damagesCsv: [],
      selectedDamages: {},
      searchTextDamage: '',
      selectedNameDamage: 'Nama',
      selectedRoomDamage: 'Ruangan',
      selectedEmployeeDamage: 'Karyawan',
      selectedCategoryDamage: 'Kategori',

      repairsCsv: [],
      selectedRepairs: {},
      searchTextRepair: '',
      selectedNameRepair: 'Nama',
      selectedRoomRepair: 'Ruangan',
      selectedEmployeeRepair: 'Karyawan',
      selectedCategoryRepair: 'Kategori',
    };
  },
  computed: {
    DamageHistoryList() {
      return this.$store.state.DamageHistoryList;
    },
    RepairHistoryList() {
      return this.$store.state.RepairHistoryList;
    },
    filteredDamageHistorys() {
      return this.DamageHistoryList.filter(Kerusakan =>
        this.searchDamageHistorys(Kerusakan, this.searchTextDamage.toLowerCase()) &&
        (this.selectedNameDamage === 'Nama' || Kerusakan.Usage.Inventory.nama === this.selectedNameDamage) && (this.selectedRoomDamage === 'Ruangan' || Kerusakan.Usage.Room.nama === this.selectedRoomDamage) && (this.selectedEmployeeDamage === 'Karyawan' || Kerusakan.Usage.Employee.nama === this.selectedEmployeeDamage) && (this.selectedCategoryDamage === 'Kategori' || Kerusakan?.Usage?.Employee?.Category?.nama === this.selectedCategoryDamage)
      );
    },
    filteredDamagesCsv() {
      return this.damagesCsv.filter(Kerusakan =>
        this.searchDamageHistorys(Kerusakan, this.searchTextDamage.toLowerCase())
      );
    },
    uniqueDamageNames() {
      if (!this.DamageHistoryList || !Array.isArray(this.DamageHistoryList)) {
        return [];
      }
      const nameDamages = this.DamageHistoryList
        .map(Kerusakan => Kerusakan.Usage?.Inventory?.nama)
        .filter(Boolean);

      return [...new Set(nameDamages)];
    },
    uniqueDamageRooms() {
      if (!this.DamageHistoryList) {
        return [];
      }
      const roomDamages = this.DamageHistoryList.map(Kerusakan => Kerusakan.Usage?.Room?.nama).filter(Boolean);
      return [...new Set(roomDamages)];
    },
    uniqueDamageEmployees() {
      if (!this.DamageHistoryList) {
        return [];
      }
      const employeeDamages = this.DamageHistoryList.map(Kerusakan => Kerusakan.Usage?.Employee?.nama).filter(Boolean);
      return [...new Set(employeeDamages)];
    },
    uniqueDamageCategories() {
      if (!this.DamageHistoryList) {
        return [];
      }
      const categoryDamages = this.DamageHistoryList.map(Kerusakan => Kerusakan.Usage?.Inventory?.Category?.nama).filter(Boolean);
      return [...new Set(categoryDamages)];
    },


    filteredRepairHistorys() {
      return this.RepairHistoryList.filter(Perbaikan =>
        this.searchRepairHistorys(Perbaikan, this.searchTextRepair.toLowerCase()) &&
        (this.selectedNameRepair === 'Nama' || Perbaikan.ReportHistoryKerusakan.Usage.Inventory.nama === this.selectedNameRepair) && (this.selectedRoomRepair === 'Ruangan' || Perbaikan.ReportHistoryKerusakan.Usage.Room.nama === this.selectedRoomRepair) && (this.selectedEmployeeRepair === 'Karyawan' || Perbaikan.ReportHistoryKerusakan.Usage.Employee.nama === this.selectedEmployeeRepair) && (this.selectedCategoryRepair === 'Kategori' || Perbaikan?.ReportHistoryKerusakan.Usage?.Employee?.Category?.nama === this.selectedCategoryRepair)
      );
    },
    filteredRepairsCsv() {
      return this.repairsCsv.filter(Perbaikan =>
        this.searchRepairHistorys(Perbaikan, this.searchTextRepair.toLowerCase())
      );
    },
    uniqueRepairNames() {
      if (!this.RepairHistoryList || !Array.isArray(this.RepairHistoryList)) {
        return [];
      }
      const nameRepairs = this.RepairHistoryList
        .map(Perbaikan => Perbaikan.ReportHistoryKerusakan?.Usage?.Inventory?.nama)
        .filter(Boolean);

      return [...new Set(nameRepairs)];
    },
    uniqueRepairRooms() {
      if (!this.RepairHistoryList) {
        return [];
      }
      const roomRepairs = this.RepairHistoryList.map(Perbaikan => Perbaikan.ReportHistoryKerusakan?.Usage?.Room?.nama).filter(Boolean);
      return [...new Set(roomRepairs)];
    },
    uniqueRepairEmployees() {
      if (!this.RepairHistoryList) {
        return [];
      }
      const employeeRepairs = this.RepairHistoryList.map(Perbaikan => Perbaikan.ReportHistoryKerusakan?.Usage?.Employee?.nama).filter(Boolean);
      return [...new Set(employeeRepairs)];
    },
    uniqueRepairCategories() {
      if (!this.RepairHistoryList) {
        return [];
      }
      const categoryRepairs = this.RepairHistoryList.map(Perbaikan => Perbaikan.ReportHistoryKerusakan?.Usage?.Inventory?.Category?.nama).filter(Boolean);
      return [...new Set(categoryRepairs)];
    },
  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'problemHistories',
      dataKey: 'Kerusakan',
      mutation: 'setDamageHistoryList',
    });

    this.$store.dispatch('fetchData', {
      endpoint: 'repairHistories',
      dataKey: 'Perbaikan',
      mutation: 'setRepairHistoryList',
    });
  },
  methods: {
    redirectToDamageAddPage() {
      window.location.href = 'http://localhost:8081/damageHistoryADD';
    },
    redirectToDamageEditPage(id) {
      router.push({ path: `/damageHistory/${id}` });
    },
    redirectToRepairAddPage() {
      window.location.href = 'http://localhost:8081/repairHistoryADD';
    },
    redirectToRepairEditPage(id) {
      router.push({ path: `/repairHistory/${id}` });
    },
    deleteDamageHistory(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/problemHistories/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
          })
          .catch(error => {
            console.error('Error deleting item:', error);
            alert('Failed to delete item.');
          });
      }
    },
    deleteRepairHistory(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios.delete(`http://localhost:8080/api/repairHistories/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
          })
          .catch(error => {
            console.error('Error deleting item:', error);
            alert('Failed to delete item.');
          });
      }
    },
    searchDamageHistorys(damages, searchTextDamage) {
      return Object.values(damages).some(
        value => value && value.toString().toLowerCase().includes(searchTextDamage)
      );
    },
    searchRepairHistorys(repairs, searchTextRepair) {
      return Object.values(repairs).some(
        value => value && value.toString().toLowerCase().includes(searchTextRepair)
      );
    },
    showDetailModal(id) {
      this.selectedDamages = id;
      this.selectedRepairs = id;
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
      doc.text('DAMAGE LIST', 80, 15);
      const headers = ['Nama'];
      const data = this.filteredDamageHistorys.map(Kerusakan => [
        Kerusakan.Usage.Inventory.nama,
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
          this.damagesCsv = jsonData
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
      const dataToSend = this.damagesCsv.length > 0 ? this.damagesCsv[0] : {};
      axios.post('http://localhost:8080/api/problemHistories', dataToSend)
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
  }
};
</script>
  
<style></style>