<template>
    <h1>Page Usage History</h1>
    <table class="table table-striped text-center ">
      <thead>
        <tr>
          <th class="text-uppercase"> Nomor Induk <br> Old </th>
          <th class="text-uppercase"> Nomor Induk <br> New </th>
          <th class="text-uppercase"> Tanggal </th>
          <th class="text-uppercase"> Ruangan <br> Old </th>
          <th class="text-uppercase"> Ruangan <br> New </th>
          <th class="text-uppercase"> Id <br> Pemakaian </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="history in UsageHistoryList" :key="history.id">
          <td>{{ history.nomor_induk_old }}</td>
        <td>{{ history.nomor_induk_new }}</td>
        <td>{{ history.tanggal }}</td>
        <td>{{ history.ruangan_old }}</td>
        <td>{{ history.ruangan_new }}</td>
        <td>{{ history.id_pemakaian }}</td>
        </tr>
      </tbody>
    </table>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        UsageHistoryList: [],
      };
    },
    mounted() {
      this.fetchHistoryPemakaian();
    },
    methods: {
      fetchHistoryPemakaian() {
        axios.get('http://localhost:8080/api/usageHistories')
          .then(response => {
            this.UsageHistoryList = response.data.ReportHistories;
          })
          .catch(error => {
            console.error('Error fetching history pemakaian:', error);
          });
      },
    },
  };
  </script>
  
  <style>
  
  </style>