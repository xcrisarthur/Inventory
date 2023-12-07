<template>
    <h1>Page Repair History</h1>
    <table class="table table-striped text-center" >
      <thead>
        <tr>
          <th class="text-uppercase"> Tanggal <br> Perbaikan </th>
          <th class="text-uppercase"> Biaya </th>
          <th class="text-uppercase"> Deskripsi </th>
          <th class="text-uppercase"> Tanggal <br> Kerusakan </th>
          <th class="text-uppercase"> Tanggal <br> Selesai Perbaikan </th>
          <th class="text-uppercase"> Id <br> Pemakaian </th>
          <th class="text-uppercase"> Tempat <br> Perbaikan </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="history in RepairHistoryList" :key="history.id">
          <td>{{ history.tanggal_perbaikan }}</td>
        <td>{{ history.biaya }}</td>
        <td>{{ history.deskripsi }}</td>
        <td>{{ history.tanggal_kerusakan }}</td>
        <td>{{ history.tanggal_selesai_perbaikan }}</td>
        <td>{{ history.id_pemakaian }}</td>
        <td>{{ history.tempat_perbaikan }}</td>
        </tr>
      </tbody>
    </table>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        RepairHistoryList: [],
      };
    },
    mounted() {
      this.fetchHistoryPerbaikan();
    },
    methods: {
      fetchHistoryPerbaikan() {
        axios.get('http://localhost:8080/api/repairHistories')
          .then(response => {
            this.RepairHistoryList = response.data.ReportHistories;
          })
          .catch(error => {
            console.error('Error fetching repair history:', error);
          });
      },
    },
  };
  </script>
  
  <style>


  </style>