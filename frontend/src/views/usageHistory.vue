<template>
  <div class="container text-center">
    <div class="row">
      <div class="col">
        <h1>Page Usage History</h1>
      </div>
      <div class="col pt-3">
        <div class="input-group flex-nowrap">
          <span class="input-group-text" id="addon-wrapping"><i class="fas fa-search" aria-hidden="true"></i></span>
          <input v-model="searchText" @input="filterItems" type="text" class="form-control"
            placeholder="Search History..." aria-label="Username" aria-describedby="addon-wrapping" />
        </div>
      </div>
    </div>
  </div>

  <!-- <div class="container text-center">
    <div class="row align-items-start">
      <div class="col">
        <p class="fw-bold fs-4">F I L T E R</p>
      </div>
      <div class="col">
        <select v-model="selectedIndukOld" class="form-select" aria-label="Default select example">
          <option value="InOld">Induk Old</option>
          <option v-for="inOld in uniqueIndukOlds" :key="inOld" :value="inOld">{{ inOld }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedIndukNew" class="form-select" aria-label="Default select example">
          <option value="InNew">Induk New</option>
          <option v-for="inNew in uniqueIndukNews" :key="inNew" :value="inNew">{{ inNew }}</option>
        </select>
      </div>
      <div class="col">
        <select v-model="selectedTanggal" class="form-select" aria-label="Default select example">
          <option value="Tanggal">Tanggal</option>
          <option v-for="tanggal in uniqueTanggals" :key="tanggal" :value="tanggal">{{ tanggal }}</option>
        </select>
      </div>
    </div>
  </div> -->

  <table class="table table-striped text-center ">
    <thead>
      <tr>
        <th class="text-uppercase"> Nomor Induk <br> Old </th>
        <th class="text-uppercase"> Nomor Induk <br> New </th>
        <th class="text-uppercase"> Tanggal </th>
        <th class="text-uppercase"> Ruangan <br> Old </th>
        <th class="text-uppercase"> Ruangan <br> New </th>
        <!-- <th class="text-uppercase"> Id <br> Pemakaian </th> -->
      </tr>
    </thead>
    <tbody>
      <tr v-for="history in UsageHistoryList" :key="history.id">
        <td>{{ history.nomor_induk_old}}</td>
        <td>{{ history.nomor_induk_new }}</td>
        <td>{{ history.tanggal }}</td>
        <td>{{ history.ruangan_old }}</td>
        <td>{{ history.ruangan_new }}</td>
        <!-- <td>{{ history.Usage.Room.nama }}</td> -->
      </tr>
    </tbody>
  </table>
</template>
  
<script>
// import axios from 'axios';
// import router from '../router';
// import jsPDF from 'jspdf';
// import Papa from 'papaparse';
// import 'jspdf-autotable';

export default {
  data() {
    return {
      usageHistoryCsv: [],
      selectedUsageHistory: {},
      fileSelected: false,
      modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',
      searchText: '',
      selectedIndukOld: 'Pemakai Sebelumnya',
      selectedIndukNew: 'Pemakai Sekarang',
      selectedTanggal: 'Tanggal',
      selectedRuanganOld: 'Ruangan Sebelumnya',
      selectedRuanganNew: 'Ruangan Sekarang',
    };
  },
  computed: {
    UsageHistoryList() {
      return this.$store.state.UsageHistoryList;
    },
    filteredUsageHistories() {
      return this.usageHistories.filter(ReportHistories =>
        this.searchInventories(ReportHistories, this.searchText.toLowerCase()) &&
        (this.selectedIndukOld === 'Pemakai Sebelumnya' || ReportHistories.nomor_induk_old === this.selectedIndukOld) &&
        (this.selectedNomor === 'Pemakai Sekarang' || ReportHistories.nomor_induk_new === this.selectedNomor) &&
        (this.selectedTanggal === 'Tanggal' || ReportHistories.tanggal === this.selectedTanggal) &&
        (this.selectedRuanganOld === 'Ruangan Sebelumnya' || ReportHistories.ruangan_old === this.selectedRuanganOld)
        (this.selectedRuanganNew === 'Ruangan Sekarang' || ReportHistories.ruangan_new === this.selectedRuanganNew)

      );
    },
    filteredInventoriesCsv() {
      return this.usageHistoryCsv.filter(ReportHistories =>
        this.searchInventories(ReportHistories, this.searchText.toLowerCase())
      );
    },
    uniqueIndukOlds() {
      const indukOld = this.usageHistories.map(ReportHistories => ReportHistories.nomor_induk_old).filter(Boolean);
      return [...new Set(indukOld)];
    },
    uniqueIndukNews() {
      const indukNew = this.usageHistories.map(ReportHistories => ReportHistories.nomor_induk_new).filter(Boolean);
      return [...new Set(indukNew)];
    },
    uniqueTanggals() {
      const tanggal = this.usageHistories.map(ReportHistories => ReportHistories.tanggal).filter(Boolean);
      return [...new Set(tanggal)];
    },
    uniqueRoomOld() {
      const roomOld = this.usageHistories.map(ReportHistories => ReportHistories.ruangan_old).filter(Boolean);
      return [...new Set(roomOld)];
    },
    uniqueRoomNew() {
      const roomNew = this.usageHistories.map(ReportHistories => ReportHistories.ruangan_new).filter(Boolean);
      return [...new Set(roomNew)];
    },

  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'usageHistories',
      dataKey: 'ReportHistories',
      mutation: 'setUsageHistoryList',
    });
  },
  methods: {
    searchHistory(id, searchText) {
      return Object.values(id).some(
        value => value && value.toString().toLowerCase().includes(searchText)
      );
    },
    showDetailModal(id) {
      this.selectedInventories = id;
      this.modalBackgroundColor = 'rgba(0, 0, 0, 0.6)';
      const modalElement = document.getElementById('staticBackdrop');
      if (modalElement) {
        modalElement.modal('show');
      } else {
        console.error('Modal element not found.');
      }
    },
  }
};
</script>
  
<style></style>